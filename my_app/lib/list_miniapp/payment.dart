import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/list_miniapp/redux/use_redux.dart';
import 'package:provider/provider.dart';
import 'complete.dart';
import 'providers/manager.dart';

class placeoder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _placeoder();
}

class _placeoder extends State<placeoder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.brown[300],
            title: Text(
              "Cart",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  showDeliveryAddressBottomSheet(context);
                },
                child: Text("Pay"),
              )
            ],
            centerTitle: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
          child: StoreConnector<cartState, Map<product, int>>(
              builder: (context, cartProducts) {
                if (cartProducts.isEmpty) {
                  return Center(
                    child: Text("cart dont have item"),
                  );
                } else {
                  return Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: cartProducts.length,
                              itemBuilder: (context, index) {
                                final product =
                                    cartProducts.keys.elementAt(index);
                                final quantity = cartProducts[product]!;
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[700],
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
                                        // crossAxisAlignment: CrossAxisAlignment.start,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${product.name}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${product.cost} USD",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                          right: 5,
                                          bottom: 0,
                                          child: Row(
                                            children: [
                                              StoreConnector<cartState,
                                                  VoidCallback>(
                                                builder: (context, decrease) {
                                                  return ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      minimumSize: Size(20, 20),
                                                      padding:
                                                          EdgeInsets.all(2),
                                                    ),
                                                    onPressed: decrease,
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 15,
                                                    ),
                                                  );
                                                },
                                                converter: (store) => () =>
                                                    store.dispatch(
                                                        DecreaseQuantityAction(
                                                            product)),
                                              ),
                                              Text("${quantity}"),
                                              StoreConnector<cartState,
                                                  VoidCallback>(
                                                builder: (context, decrease) {
                                                  return ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      minimumSize: Size(20, 20),
                                                      padding:
                                                          EdgeInsets.all(2),
                                                    ),
                                                    onPressed: decrease,
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 15,
                                                    ),
                                                  );
                                                },
                                                converter: (store) => () =>
                                                    store.dispatch(
                                                        IncreaseQuantityAction(
                                                            product)),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                );
                              }))
                    ],
                  );
                }
              },
              converter: (store) => store.state.products),
        ));
  }
}

void showDeliveryAddressBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Để cho phép cuộn nếu nội dung lớn
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.all(16.0), // Thêm padding bên ngoài
        child: Column(
          mainAxisSize: MainAxisSize.min, // Cho phép chiều cao tối thiểu
          children: [
            Text(
              "Delivery Address",
              style: TextStyle(color: Colors.grey, fontSize: 22),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Please write your address clearly",
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey[700],
                  ),
                ),
                StoreConnector<cartState, double>(
                    builder: (context, total) {
                      return Text("$total",
                          style:
                              TextStyle(fontSize: 20, color: Colors.red[500]));
                    },
                    converter: (store) => store.state.TotalPrice)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => conguralution()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(255, 164, 81, 1),
                ),
                child: Center(
                  child: Text(
                    "PLACE ORDER",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
