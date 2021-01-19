import 'package:bookzapp/model/Book.dart';
import 'package:bookzapp/screens/MyBookScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  void removeFromCart() {
                    String uid = context.read<User>().uid;
                    DocumentReference document =
                        FirebaseFirestore.instance.collection('users').doc(uid);
                    document
                        .update({
                          'shoppingCart': FieldValue.arrayRemove([book.isbn])
                        })
                        .then((value) => {
                              print("ShoppingCart Updated"),
                            })
                        .catchError((error) => {
                              print("Failed to update ShoppingCart: $error"),
                            });
                    /*Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(errorMsg)));*/
                    Navigator.of(context).pop();
                  }

                  return AlertDialog(
                    title: Text('Are you sure you want to delete?'),
                    content: Text(book.title),
                    actions: <Widget>[
                      OutlineButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('No')),
                      FlatButton(onPressed: removeFromCart, child: Text('Yes')),
                    ],
                  );
                });
          },
        ),
        onTap: () {
          print("open bookScreen for: " + book.isbn.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyBookScreen(
                        book: book,
                      )));
        },
      ),
    );
  }
}
