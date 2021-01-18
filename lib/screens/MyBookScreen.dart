import 'package:bookzapp/model/Book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      floatingActionButton: _ButtonHandler(book),
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

class _ButtonHandler extends StatefulWidget {
  final Book book;

  const _ButtonHandler(this.book);

  @override
  __ButtonHandlerState createState() => __ButtonHandlerState(book);
}

class __ButtonHandlerState extends State<_ButtonHandler> {
  bool add = true;
  final Book book;

  __ButtonHandlerState(this.book);

  void showError(context, errorMsg) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
  }

  void swapState() {
    setState(() {
      add = !add;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> list;
    String uid = context.watch<User>().uid;
    DocumentReference document =
        FirebaseFirestore.instance.collection('users').doc(uid);
    document.get().then((value) {
      print('button check: ' + value.get('shoppingCart').toString());
      list = value.get('shoppingCart');

      if (list.contains(book.isbn)) {
        setState(() {
          add = false;
        });
      }
    });
    return (add)
        ? FloatingActionButton(
            child: Icon(Icons.add),
            tooltip: "add to cart",
            onPressed: () {
              // todo: fireStore shoppingCart update here

              String uid = context.read<User>().uid;
              DocumentReference document =
                  FirebaseFirestore.instance.collection('users').doc(uid);
              document
                  .update({
                    'shoppingCart': FieldValue.arrayUnion([book.isbn])
                  })
                  .then((value) => {
                        print("Book added to cart"),
                        showError(context, "Book added to cart"),
                      })
                  .catchError((error) => {
                        print("Failed to update ShoppingCart: $error"),
                        showError(
                            context, "Failed to update ShoppingCart: $error"),
                      });
              swapState();
            })
        : FloatingActionButton(
            child: Icon(Icons.check),
            tooltip: "add to cart",
            onPressed: () {
              // todo: fireStore shoppingCart update here

              String uid = context.read<User>().uid;
              DocumentReference document =
                  FirebaseFirestore.instance.collection('users').doc(uid);
              document
                  .update({
                    'shoppingCart': FieldValue.arrayRemove([book.isbn])
                  })
                  .then((value) => {
                        print("Book removed from cart"),
                        showError(context, "Book removed from cart"),
                      })
                  .catchError((error) => {
                        print("Failed to update ShoppingCart: $error"),
                        showError(
                            context, "Failed to update ShoppingCart: $error"),
                      });
              swapState();
            });
  }
}
