import 'dart:math';

import 'package:flutter/material.dart';
import 'two.dart';
import 'package:dio/dio.dart';
import 'apiservice/user.dart';
import 'apiservice/api_service.dart';
import 'three.dart';

// ignore: camel_case_types
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<StatefulWidget> createState() => _login();
}

class _login extends State<login> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final Dio dio = Dio();
  late ApiClient authService;

  @override
  void initState() {
    super.initState();

    // Khởi tạo authService trong initState
    authService = ApiClient(dio);
  }

  String message = "";
  Future<void> login() async {
    try {
      final response = await authService.login(User(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      ));

      setState(() {
        message = response.data['message'];
        if (message == 'done') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => homemain()));
        }
      });
    } catch (e) {
      setState(() {
        message = "email or password is incorrect";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(34, 40, 52, 1),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: const Color.fromRGBO(52, 182, 233, 1)),
                    borderRadius: BorderRadius.circular(50)),
                child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/intro3.jpg"),
                )),
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                      width: 1, color: const Color.fromRGBO(52, 182, 233, 1))),
              child: TextField(
                controller: emailcontroller,
                decoration: const InputDecoration(
                    hintText: "email",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
                      width: 1, color: const Color.fromRGBO(0, 0, 0, 1))),
              child: TextField(
                obscureText: true,
                controller: passwordcontroller,
                decoration: const InputDecoration(
                    hintText: "password",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none),
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "${message}",
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: login,
              child: Container(
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
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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
                      "Sign Up",
                      style: TextStyle(
                          color: Color.fromRGBO(52, 182, 233, 1), fontSize: 14),
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
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Sign_up(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Lướt từ phải qua trái
        const end = Offset.zero;
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
