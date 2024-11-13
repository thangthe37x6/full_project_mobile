import 'package:flutter/material.dart';
import 'one.dart';

class firstscreen extends StatelessWidget {
  firstscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(_createRoute());
      },
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              "assets/intro3.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 240),
                child: Column(
                  children: [
                    Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("WELCOME TO"),
                        )),
                    SizedBox(
                      height: 220,
                    ),
                    Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "THE WORLD OF FASTFOOD",
                            style: TextStyle(),
                          ),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => login(),
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
