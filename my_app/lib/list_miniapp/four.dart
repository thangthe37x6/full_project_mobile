import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'payment.dart';
import 'providers/manager.dart';
import 'redux/use_redux.dart';

class contain1 extends StatefulWidget {
  final String name;
  final double cost;
  final String image;

  const contain1(
      {Key? key, required this.name, required this.cost, required this.image})
      : super(key: key);

  @override
  _contain1 createState() => _contain1();
}

class _contain1 extends State<contain1> {
  bool favorite_1 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 10,
              color: Colors.grey.withOpacity(0.15),
              offset: Offset(0, 3))
        ],
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: 150,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            top: 40,
            left: 35,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                widget.image,
                height: 85,
                width: 85,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 140, left: 15, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  "${widget.cost} USD",
                  style: TextStyle(
                      color: Color.fromRGBO(255, 164, 81, 1), fontSize: 15),
                ),
              ],
            ),
          ),
          Positioned(
              left: 0,
              top: 0,
              child: StoreConnector<cartState, VoidCallback>(
                  builder: (context, add) {
                    return IconButton(
                      onPressed: add,
                      icon: Icon(Icons.add),
                      color: Color.fromRGBO(255, 164, 81, 1),
                      splashColor: Color.fromRGBO(255, 164, 81, 1),
                    );
                  },
                  converter: (store) => () => store.dispatch(addProduct(
                      Product: product(
                          cost: widget.cost,
                          name: widget.name,
                          image: widget.image))))),
          Positioned(
              right: 15,
              top: 15,
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (!Provider.of<Cart>(context, listen: false).isFavorite(
                        Product(
                            name: widget.name,
                            cost: widget.cost,
                            image: widget.image))) {
                      // Nếu không có trong danh sách yêu thích, thì thêm vào
                      Provider.of<Cart>(context, listen: false).addFavorite(
                          Product(
                              cost: widget.cost,
                              name: widget.name,
                              image: widget.image));
                    } else {
                      // Nếu đã có trong danh sách yêu thích, thì xóa khỏi danh sách
                      Provider.of<Cart>(context, listen: false).removeFavorite(
                          Product(
                              cost: widget.cost,
                              name: widget.name,
                              image: widget.image));
                    }
                  });
                },
                child: Icon(
                  Provider.of<Cart>(context).isFavorite(Product(
                          name: widget.name,
                          cost: widget.cost,
                          image: widget.image))
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Provider.of<Cart>(context).isFavorite(Product(
                          name: widget.name,
                          cost: widget.cost,
                          image: widget.image))
                      ? Color.fromRGBO(255, 164, 81, 1)
                      : Color.fromRGBO(255, 164, 81, 1),
                  size: 20,
                ),
              )),
        ],
      ),
    );
  }
}

class FirstMenu extends StatefulWidget {
  @override
  _FirstMenuState createState() => _FirstMenuState();
}

class _FirstMenuState extends State<FirstMenu> {
  // Dữ liệu mẫu
  List<dynamic> items = [];
  final Dio dio = Dio();
  String mess = "no food";
  Future<void> getData() async {
    try {
      final response = await dio.get('http://10.0.2.2:3000/api/data');
      setState(() {
        items = response.data['data'];
      });
    } catch (e) {
      mess = "${e}";
    }
  }

  @override
  void initState() {
    super.initState();
    getData(); // Fetch data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 249,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(items.length, (index) {
              return contain1(
                name: items[index]['namefood'],
                cost: double.parse(items[index]['price']),
                image: items[index]['image'],
              );
            }))));
  }
}

class secondMenu extends StatefulWidget {
  @override
  _secondMenuState createState() => _secondMenuState();
}

class _secondMenuState extends State<secondMenu> {
  // Dữ liệu mẫu
  List<dynamic> items = [];
  final Dio dio = Dio();
  String mess = "no food";
  Future<void> getData() async {
    try {
      final response = await dio.get('http://10.0.2.2:3000/api/data');
      setState(() {
        items = response.data['restaurant'];
      });
    } catch (e) {
      mess = "${e}";
    }
  }

  @override
  void initState() {
    super.initState();
    getData(); // Fetch data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(items.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: container2(
            address: items[index]['name'],
            name: items[index]['address'],
            acountstar: items[index]['acountstar'],
            time: items[index]['time'],
            image: items[index]['image'],
          ),
        );
      }),
    );
  }
}

class container2 extends StatelessWidget {
  final String name;
  final String address;
  final double acountstar;
  final int time;
  final String image;
  const container2(
      {Key? key,
      required this.name,
      required this.address,
      required this.acountstar,
      required this.time,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 140,
                ),
              ),
              Text(
                address,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                name,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star_rate_outlined,
                        color: Color.fromRGBO(255, 164, 81, 1),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("${acountstar}")
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.fire_truck,
                        color: Color.fromRGBO(255, 164, 81, 1),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Free")
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        color: Color.fromRGBO(255, 164, 81, 1),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("${time} min")
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

Widget mainmenu() {
  return ListView(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    children: [
      // All Categories Section
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "All Categories",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                "See All",
                style: TextStyle(color: Colors.grey),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 14,
              ),
            ],
          ),
        ],
      ),

      // First Menu
      FirstMenu(),

      SizedBox(height: 15),

      // Open Restaurants Section
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Open Restaurants",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                "See All",
                style: TextStyle(color: Colors.grey),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 14,
              ),
            ],
          ),
        ],
      ),

      SizedBox(height: 15),

      // List of Restaurants
      secondMenu()
    ],
  );
}

class shoppingcart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<cartState, Map<product, int>>(
        builder: (context, cartProducts) {
          if (cartProducts.isEmpty) {
            return Center(
              child: Text("you do not add"),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Stack(
                children: [
                  ListView.builder(
                      itemCount: cartProducts.length,
                      itemBuilder: (context, index) {
                        final product = cartProducts.keys.elementAt(index);
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue[300],
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5,
                                    offset: Offset(0, 4),
                                    color: Colors.grey)
                              ]),
                          margin: EdgeInsets.only(bottom: 15),
                          child: Stack(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    ),
                                    child: Image.asset(
                                      product.image,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${product.name}",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("thịt, gà , rau xà lách, ớt, ...",
                                          style:
                                              TextStyle(color: Colors.black87)),
                                      Text("Note: .........",
                                          style:
                                              TextStyle(color: Colors.black54)),
                                    ],
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 7,
                                right: 14,
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          color: Colors.red[600],
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "about 30 min",
                                          style: TextStyle(
                                              color: Colors.red[600],
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "${product.cost} USD",
                                      style: TextStyle(
                                          color: Colors.red[600], fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: StoreConnector<cartState,
                                          VoidCallback>(
                                      builder: (context, removep) {
                                        return IconButton(
                                            onPressed: removep,
                                            icon: Icon(
                                              Icons.close,
                                              size: 20,
                                              color: Colors.white,
                                            ));
                                      },
                                      converter: (store) => () =>
                                          store.dispatch(
                                              removeProduct(Product: product))))
                            ],
                          ),
                        );
                      }),
                  Positioned(
                    bottom: 30,
                    right: 20,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => placeoder()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(13),
                            backgroundColor: Color.fromRGBO(255, 164, 81, 1)),
                        child: Icon(
                          Icons.wallet,
                          color: Colors.grey,
                        )),
                  )
                ],
              ),
            );
          }
        },
        converter: (store) => store.state.products);
  }
}

class myfavorite extends StatefulWidget {
  const myfavorite({super.key});

  @override
  State<StatefulWidget> createState() => _myfavorite();
}

class _myfavorite extends State<myfavorite> {
  @override
  Widget build(BuildContext context) {
    var favorite = context.watch<Cart>();
    return Stack(children: [
      ListView(padding: EdgeInsets.only(left: 10, right: 10), children: [
        Column(
          children: [
            favorite.favorite.isEmpty
                ? Center(child: Text("Cart is empty"))
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Số lượng phần tử trên mỗi hàng
                      crossAxisSpacing:
                          10.0, // Khoảng cách giữa các phần tử theo chiều ngang
                      mainAxisSpacing:
                          10.0, // Khoảng cách giữa các phần tử theo chiều dọc
                      childAspectRatio:
                          0.9, // Tỉ lệ giữa chiều rộng và chiều cao của phần tử
                    ),
                    itemCount: favorite.favorite.length, // Tổng số phần tử
                    shrinkWrap:
                        true, // Cho phép GridView điều chỉnh kích thước theo nội dung
                    physics:
                        NeverScrollableScrollPhysics(), // Tắt scroll của GridView nếu cần
                    itemBuilder: (context, index) {
                      final product = favorite.favorite[index];
                      return contain1(
                        name: product.name,
                        cost: product.cost,
                        image: product.image,
                      );
                    },
                  )
          ],
        ),
      ]),
      Positioned(
        bottom: 30,
        right: 20,
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => placeoder()),
              );
            },
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(13),
                backgroundColor: Color.fromRGBO(255, 164, 81, 1)),
            child: Icon(
              Icons.wallet,
              color: Colors.grey,
            )),
      )
    ]);
  }
}
