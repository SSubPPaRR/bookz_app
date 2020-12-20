import 'package:flutter/material.dart';

class Book{
  final String title;
  final String subTitle;
  final int isbn;
  final double price;
  final String image;
  final String url;

  Book({
    @required this.title,
    @required this.subTitle,
    @required this.isbn,
    @required this.price,
    @required this.image,
    @required this.url,
});

  @override
  String toString() {
    return 'Book{isbn: $isbn, title: $title, price: \$$price}';
  }

  factory Book.fromJson(Map<String, dynamic> json) {

      return Book(
        isbn: int.parse(json['isbn13']),
        title: json['title'] as String,
        subTitle: json['subtitle'] as String,
        price: double.parse(json['price'].toString().replaceFirst('\$', '')),
        image: json['image'] as String,
        url: json['url'] as String,
      );
  }

}
