import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app/list_miniapp/one.dart';
import 'four.dart';
import 'profile.dart';

class homemain extends StatefulWidget {
  const homemain({super.key});
  @override
  State<StatefulWidget> createState() => _homemain();
}

class _homemain extends State<homemain> {
  int _selectedindex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    mainmenu(),
    myfavorite(),
    shoppingcart(),
    myprofile(),
    Center(child: Text("Không có thông báo nào cả ....")),
  ];
  PreferredSizeWidget? buildAppBar() {
    switch (_selectedindex) {
      case 1:
        return AppBar(
          title: Text(
            "my favorite food",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        );
      case 2:
        return AppBar(
          title: Text(
            "Cart",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        );
      case 3:
        return AppBar(
          title: Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Wrap(
                      children: [
                        ListTile(
                          leading: Icon(Icons.edit),
                          title: Text("Edit my profile"),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text("Settings"),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.logout, color: Colors.red),
                          title: Text(
                            "Logout",
                            style: TextStyle(color: Colors.red),
                          ),
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login()));
                            });
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
          centerTitle: true,
        );

      case 4:
        return AppBar(
          title: Text(
            "Notification",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        );

      default:
        return PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: Container(
            padding: EdgeInsets.only(
                top: 40,
                left: MediaQuery.of(context).size.width * 0.2,
                right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Choose your food",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Container(
                  width: 50,
                  height: 45,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        offset: Offset(0, 4),
                        color: Colors.grey,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromRGBO(255, 164, 81, 1),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Thực hiện hành động khi bấm vào nút search
                    },
                    icon: Icon(
                      Icons.search_sharp,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: buildAppBar(),
      body: _widgetOptions.elementAt(_selectedindex),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 9.0,
        child: Container(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedindex = 0;
                  });
                },
                icon: Icon(Icons.home),
                color: _selectedindex == 0
                    ? Color.fromRGBO(255, 164, 81, 1)
                    : Colors.grey,
              ),
              SizedBox(
                width: 25,
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedindex = 1;
                    });
                  },
                  color: _selectedindex == 1
                      ? Color.fromRGBO(255, 164, 81, 1)
                      : Colors.grey,
                  icon: Icon(Icons.favorite)),
              SizedBox(
                width: 100,
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedindex = 2;
                    });
                  },
                  color: _selectedindex == 2
                      ? Color.fromRGBO(255, 164, 81, 1)
                      : Colors.grey,
                  icon: Icon(Icons.shopping_cart)),
              SizedBox(
                width: screenwidth * 0.06,
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedindex = 3;
                    });
                  },
                  color: _selectedindex == 3
                      ? Color.fromRGBO(255, 164, 81, 1)
                      : Colors.grey,
                  icon: Icon(Icons.person)),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(40), // Tùy chỉnh BorderRadius
        child: Container(
          width: 70,
          height: 70,
          color: _selectedindex == 4
              ? Color.fromRGBO(255, 164, 81, 1)
              : Colors.grey, // Màu của nút
          child: IconButton(
            onPressed: () {
              setState(() {
                _selectedindex = 4;
              });
            },
            icon: Icon(Icons.notifications_active,
                color: _selectedindex == 4 ? Colors.grey : Colors.white,
                size: 30),
          ),
        ),
      ),
    );
  }
}
