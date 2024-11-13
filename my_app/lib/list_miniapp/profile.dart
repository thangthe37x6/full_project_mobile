import 'package:flutter/material.dart';

class myprofile extends StatefulWidget {
  const myprofile({super.key});

  @override
  State<StatefulWidget> createState() => _myprofile();
}

class _myprofile extends State<myprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              "assets/intro3.jpg",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "thang",
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.facebook,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.tiktok,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.home,
                    size: 19,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "DANANG, VIETNAM",
                    style: TextStyle(fontSize: 19),
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.email,
                    size: 19,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "conga@gmail.com",
                    style: TextStyle(fontSize: 19),
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 19,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "0312389123471",
                    style: TextStyle(fontSize: 19),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
