import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<Product, int> _cartItems = {};

  Map<Product, int> get cartItems => _cartItems;

  int get itemCount => _cartItems.values.fold(0, (sum, quantity) => sum + quantity);

  double get totalPrice => _cartItems.entries
      .map((entry) => entry.key.price * entry.value)
      .fold(0, (sum, price) => sum + price);

  void addToCart(Product product) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + 1;
    } else {
      _cartItems[product] = 1;
    }
    notifyListeners();
  }

  void increaseQuantity(Product product) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + 1;
      notifyListeners();
    }
  }

  void decreaseQuantity(Product product) {
    if (_cartItems.containsKey(product)) {
      if (_cartItems[product]! > 1) {
        _cartItems[product] = _cartItems[product]! - 1;
      } else {
        _cartItems.remove(product);
      }
      notifyListeners();
    }
  }

  int getQuantity(Product product) => _cartItems[product] ?? 0;

  bool isProductInCart(Product product) => _cartItems.containsKey(product);
}
