import 'dart:convert';

class Product {
  final int id;
  final String title;
  final String imageUrl;
  final double price;
  final String description;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image'],
      price: json['price'].toDouble(),
      description: json['description'],

    );
  }
}

List<Product> parseProducts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}




