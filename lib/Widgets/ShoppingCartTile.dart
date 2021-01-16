import 'package:bookzapp/model/Book.dart';
import 'package:flutter/material.dart';

class MyShoppingCartTile extends StatelessWidget {
  final Book book;

  MyShoppingCartTile({this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.book),
        title: Text(book.title),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed:
              null, //todo: delete book from list (remove from fireStore & refresh list), popup confirmation?
        ),
        onTap: () {
          print("open bookScreen for: " + book.isbn.toString());
        },
      ),
    );
  }
}
