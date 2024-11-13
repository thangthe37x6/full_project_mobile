import 'package:flutter/material.dart';
import 'one.dart';
import 'three.dart';
import 'package:dio/dio.dart';
import 'apiservice/user.dart';
import 'apiservice/api_service.dart';

// ignore: camel_case_types
class Sign_up extends StatefulWidget {
  const Sign_up({super.key});
  @override
  State<Sign_up> createState() => _Sign_up();
}

class _Sign_up extends State<Sign_up> {
  final password = TextEditingController();
  final c_password = TextEditingController();
  final emailcontroll = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final Dio dio = Dio();

  late ApiClient regis;
  String mess = '';

  @override
  void initState() {
    super.initState();
    regis = ApiClient(dio);
    emailFocus.addListener(() {
      if (!emailFocus.hasFocus) {
        setState(() {
          emailerr = validateEmail(emailcontroll.text);
        });
      }
    });
  }

  Future<void> register() async {
    // Kiểm tra tính hợp lệ trước khi gửi yêu cầu
    setState(() {
      emailerr = validateEmail(emailcontroll.text);
      p_pw(); // Kiểm tra password hợp lệ
      p_c_pw(); // Kiểm tra confirm password hợp lệ
    });

    if (emailerr == null && passworderr == null) {
      try {
        final response = await regis.register(User(
          email: emailcontroll.text,
          password: password.text,
        ));

        setState(() {
          mess = response.data.containsKey('message')
              ? response.data['message']
              : 'Đã xảy ra lỗi từ server';
          if (mess == "done") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => homemain()),
            );
          }
        });
      } catch (e) {
        setState(() {
          mess = "lỗi ${e.toString()} ";
        });
      }
    } else {
      setState(() {
        mess = "Vui lòng kiểm tra lại thông tin nhập";
      });
    }
  }

  String? emailerr;
  String? passworderr;
  void p_pw() {
    if (password.text.isEmpty || c_password.text.isEmpty) {
      setState(() {
        passworderr = "please fill out your password (<_>)";
      });
    } else {
      setState(() {
        passworderr = null;
      });
    }
  }

  // ignore: non_constant_identifier_names
  void p_c_pw() {
    if (c_password.text != password.text) {
      setState(() {
        passworderr = "sorry passwords don't match :)";
      });
    } else {
      setState(() {
        passworderr = null;
      });
    }
  }

  String? validateEmail(String? value) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "please fill out your email";
    } else if (!regex.hasMatch(value)) {
      return "Invalid Email";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(34, 40, 52, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 100, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: const Color.fromRGBO(52, 182, 233, 1)),
                      borderRadius: BorderRadius.circular(50)),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage("assets/intro3.jpg"),
                  )),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border: Border.all(
                                width: 1,
                                color: const Color.fromRGBO(52, 182, 233, 1))),
                        child: TextFormField(
                          controller: emailcontroll,
                          focusNode: emailFocus,
                          decoration: const InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              if (value.isNotEmpty) {
                                emailerr == null;
                              }
                            });
                          },
                          style: const TextStyle(color: Colors.black),
                        )),
                    if (emailerr != null)
                      Text(
                        emailerr!,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0)),
                      ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 3,
                                offset: Offset(2, 4),
                                color: Color.fromRGBO(34, 40, 52, 1))
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(0, 0, 0, 1))),
                      child: TextFormField(
                        controller: password,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: "password",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          p_pw();
                        },
                      ),
                    ),
                    if (passworderr != null)
                      Text(
                        passworderr!,
                        style: const TextStyle(color: Colors.red),
                      )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 3,
                                offset: Offset(2, 4),
                                color: Color.fromRGBO(34, 40, 52, 1))
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(0, 0, 0, 1))),
                      child: TextFormField(
                        controller: c_password,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: "confirm password",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none),
                        style: const TextStyle(color: Colors.black),
                        onChanged: (value) {
                          p_c_pw();
                        },
                      ),
                    ),
                    if (passworderr != null)
                      Text(
                        passworderr!,
                        style: const TextStyle(color: Colors.red),
                      )
                  ],
                ),
              ),
              Text(
                "${mess}",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 5,
                            offset: Offset(0, 4),
                            color: Color.fromRGBO(0, 0, 0, 1))
                      ],
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromRGBO(52, 182, 233, 1)),
                  child: TextButton(
                      onPressed: register, child: const Text("SIGN UP"))),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "forget password",
                    style: TextStyle(color: Color.fromRGBO(52, 182, 233, 1)),
                  )),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(_createRoute());
                      },
                      child: const Text(
                        "login",
                        style: TextStyle(
                            color: Color.fromRGBO(52, 182, 233, 1),
                            fontSize: 14),
                      )),
                  const Text(
                    "or login another",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              ),
              SizedBox(
                width: 30,
                height: 30,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/gg.png"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailcontroll.dispose();
    emailFocus.dispose();
    super.dispose();
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => login(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0); // Lướt từ phải qua trái
        const end = Offset(0.0, 0.0);
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
