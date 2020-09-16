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
}