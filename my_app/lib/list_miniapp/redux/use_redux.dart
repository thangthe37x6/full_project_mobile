import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class product {
  final String name;
  final double cost;
  final String image;
  product({required this.name, required this.cost, required this.image});
}

class cartState {
  final Map<product, int> products;

  cartState({required this.products});

  cartState.initalState() : products = {};

  cartState copyWith({Map<product, int>? products}) {
    return cartState(products: products ?? this.products);
  }

  double get TotalPrice {
    double total = 0.0;
    products.forEach((Product, quantity) {
      total += Product.cost * quantity;
    });
    return total;
  }
}

class IncreaseQuantityAction {
  final product Product;
  IncreaseQuantityAction(this.Product);
}

class DecreaseQuantityAction {
  final product Product;
  DecreaseQuantityAction(this.Product);
}

class addProduct {
  final product Product;
  addProduct({required this.Product});
}

class removeProduct {
  final product Product;
  removeProduct({required this.Product});
}

class cleaningCart {}

cartState cartReducer(cartState state, dynamic action) {
  if (action is addProduct) {
    final newProducts = Map<product, int>.from(state.products);
    if (!newProducts.containsKey(action.Product)) {
      newProducts[action.Product] = 1;
    } else {
      return state;
    }
    return state.copyWith(products: newProducts);
  } else if (action is removeProduct) {
    final newProducts = Map<product, int>.from(state.products);
    newProducts.remove(action.Product);
    return state.copyWith(products: newProducts);
  } else if (action is cleaningCart) {
    return cartState.initalState();
  } else if (action is IncreaseQuantityAction) {
    final newProducts = Map<product, int>.from(state.products);
    if (newProducts.containsKey(action.Product)) {
      newProducts[action.Product] = newProducts[action.Product]! + 1;
    }
    return state.copyWith(products: newProducts);
  } else if (action is DecreaseQuantityAction) {
    final newProducts = Map<product, int>.from(state.products);
    if (newProducts.containsKey(action.Product)) {
      final curentNumber = newProducts[action.Product]!;
      if (curentNumber > 1) {
        newProducts[action.Product] = curentNumber - 1;
      }
      return state.copyWith(products: newProducts);
    }
  }
  return state;
}
