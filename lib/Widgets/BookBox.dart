import 'package:bookzapp/model/Book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// creates tap-able widget for [book]
/// [width] specifies widget width, if no width is specified then 160.00 is used by default

class BookBox extends StatelessWidget {
  final Book book;
  final double width;

  BookBox(this.book, {this.width = 160.0});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        width: width,
        color: Colors.black,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Image.network(book.image),
            //book title container
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child:
                  //book title
                  Text(
                book.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned.fill(
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  //TODO: implement code to open book info page or implement a function variable
                  print("Open book screen: " + book.isbn.toString());
                },
              ))),
    ]);
  }
}
