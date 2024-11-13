import 'package:flutter/material.dart';

class conguralution extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Center(child: Text("thanh toán thành công")),
    )
        // TextButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     child: Text("Return home"))
        );
  }
}
