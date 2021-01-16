import 'package:bookzapp/model/Book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBookScreen extends StatelessWidget {
  final Book book;

  const MyBookScreen({this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Image.network(book.image),
                  ),
                  Expanded(
                    flex: 3,
                    child: _BookInfo(
                      title: book.title,
                      subtitle: book.subTitle,
                      publisher: 'placeholder',
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Description:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("description here?"),
              ],
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Chapters:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("i guess we can add chapters here if we do"),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), tooltip: "add to cart", onPressed: null
          //  todo: fireStore shoppingCart update here
          ),
    );
  }
}

class _BookInfo extends StatelessWidget {
  const _BookInfo({
    Key key,
    this.title,
    this.subtitle,
    this.publisher,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String publisher;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 16.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 13.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            publisher,
            style: const TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
