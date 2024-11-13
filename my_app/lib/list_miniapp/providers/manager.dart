import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Product {
  final String name;
  final double cost;
  final String image;

  Product({required this.name, required this.cost, required this.image});

  // Hàm này so sánh 2 sản phẩm dựa trên name và cost
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.name == name && other.cost == cost;
  }

  // Hàm này tính hashCode để so sánh 2 sản phẩm đồng bộ với hàm trên
  @override
  int get hashCode => name.hashCode ^ cost.hashCode;
}

class Cart with ChangeNotifier {
  // Danh sách sản phẩm trong giỏ hàng và số lượng của chúng
  final Map<Product, int> _items = {}; // Map sản phẩm và số lượng
  List<Product> _favorite = []; // Danh sách sản phẩm yêu thích

  // Getter để truy cập danh sách yêu thích từ bên ngoài
  List<Product> get favorite => _favorite;

  // Getter để truy cập danh sách giỏ hàng từ bên ngoài
  Map<Product, int> get items => _items;

  // Kiểm tra sản phẩm có trong danh sách yêu thích không
  bool isFavorite(Product product) {
    return _favorite
        .any((item) => item.name == product.name && item.cost == product.cost);
  }

  // Thêm sản phẩm vào danh sách yêu thích
  void addFavorite(Product product) {
    if (!isFavorite(product)) {
      _favorite.add(product);
      notifyListeners(); // Báo cho Flutter cập nhật giao diện
    }
  }

  // Xóa sản phẩm khỏi danh sách yêu thích
  void removeFavorite(Product product) {
    if (isFavorite(product)) {
      _favorite.remove(product);
      notifyListeners(); // Báo cho Flutter cập nhật giao diện
    }
  }

  // Kiểm tra sản phẩm có trong giỏ hàng không
  bool isItemInCart(Product product) {
    return _items.containsKey(product);
  }

  // Thêm sản phẩm vào giỏ hàng hoặc tăng số lượng
  void addToCart(Product product) {
    if (_items.containsKey(product)) {
      _items[product] = _items[product]! + 1;
    } else {
      _items[product] = 1;
    }
    notifyListeners(); // Báo cho Flutter cập nhật giao diện
  }

  // Tăng số lượng sản phẩm
  void increaseQuantity(Product product) {
    if (_items.containsKey(product)) {
      _items[product] = _items[product]! + 1;
      notifyListeners();
    }
  }

  // Giảm số lượng sản phẩm
  void decreaseQuantity(Product product) {
    if (_items.containsKey(product) && _items[product]! > 1) {
      _items[product] = _items[product]! - 1;
      notifyListeners();
    }
  }

  // Xóa sản phẩm khỏi giỏ hàng
  void removeFromCart(Product product) {
    if (isItemInCart(product)) {
      _items.remove(product);
      notifyListeners(); // Báo cho Flutter cập nhật giao diện
    }
  }

  int getQuantity(Product product) {
    return _items.containsKey(product) ? _items[product]! : 0;
  }

  // Tính tổng giá của các sản phẩm trong giỏ hàng dựa trên số lượng
  double get totalPrice {
    return _items.entries
        .fold(0, (sum, entry) => sum + (entry.key.cost * entry.value));
  }
}
