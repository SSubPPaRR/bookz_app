import 'package:flutter/material.dart';

class Book{
  final int error;
  final String title;
  final String subTitle;
  final int isbn;
  final double price;
  final String image;
  final String url;
  int rating;
  String publisher;
  String authors;
  String desc;
  Map<String, dynamic> pdf;

  Book({
    @required this.error,
    @required this.title,
    @required this.subTitle,
    @required this.isbn,
    @required this.price,
    @required this.image,
    @required this.url,
    this.rating,
    this.publisher,
    this.authors,
    this.desc,
    this.pdf,
  });

  @override
  String toString() {
    return 'Book{isbn: $isbn, title: $title, price: \$$price}';
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      error: int.parse(json['error']),
      isbn: int.parse(json['isbn13']),
      title: json['title'] as String,
      subTitle: json['subtitle'] as String,
      price: double.parse(json['price'].toString().replaceFirst('\$', '')),
      image: json['image'] as String,
      url: json['url'] as String,
      rating: int.parse(json['rating']),
      publisher: json['publisher'],
      authors: json['authors'],
      desc: json['desc'],
      pdf: json['pdf'],
    );
  }

  factory Book.fromJsonForBookSet(Map<String, dynamic> json) {
    return Book(
      error: 0,
      isbn: int.parse(json['isbn13']),
      title: json['title'] as String,
      subTitle: json['subtitle'] as String,
      price: double.parse(json['price'].toString().replaceFirst('\$', '')),
      image: json['image'] as String,
      url: json['url'] as String,
    );
  }
}
