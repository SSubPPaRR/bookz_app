import 'package:bookzapp/model/Book.dart';
import 'package:flutter/material.dart';

class FrontPage extends StatelessWidget{
  final List<Book> _newRelease =[
    Book(
      title:"this is a test book",
      subTitle: "here is the subtitle",
      isbn: 9781484206485,
      price: 32.04,
      image: "https://itbook.store/img/books/9781484206485.png",
      url: "https://itbook.store/books/9781484206485"
    ),
    Book(
        title:"this is a test book",
        subTitle: "here is the subtitle",
        isbn: 9781484206485,
        price: 32.04,
        image: "https://itbook.store/img/books/9781484206485.png",
        url: "https://itbook.store/books/9781484206485"
    ),
    Book(
        title:"this is a test book",
        subTitle: "here is the subtitle",
        isbn: 9781484206485,
        price: 32.04,
        image: "https://itbook.store/img/books/9781484206485.png",
        url: "https://itbook.store/books/9781484206485"
    )
  ];

  //final List<Book> _cat1;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

}