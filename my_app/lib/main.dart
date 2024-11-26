import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/list_miniapp/redux/use_redux.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import './list_miniapp/one.dart';
import './list_miniapp/three.dart';
import './list_miniapp/providers/manager.dart';

void main() {
  final store =
      Store<cartState>(cartReducer, initialState: cartState.initalState());
  runApp(ChangeNotifierProvider(
    create: (context) => Cart(),
    child: MyApp(
      store: store,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final Store<cartState> store;

  MyApp({required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          home: login(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
