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
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          leading: Image.network(book.image, fit: BoxFit.fitHeight),
          title: Text(book.title),
          subtitle: Container(
            child: Text(
              '\$' + book.price.toStringAsFixed(2),
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    void removeFromCart() {
                      String uid = context.read<User>().uid;
                      DocumentReference document = FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid);
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
                      Navigator.of(context).pop();
                    }

                    return AlertDialog(
                      title: Text('Remove book?'),
                      content: Text(
                          'Are you sure you want to delete book from shopping cart?'),
                      actions: [
                        FlatButton(
                          textColor: Color(0xFF6200EE),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('CANCEL'),
                        ),
                        FlatButton(
                          textColor: Color(0xFF6200EE),
                          onPressed: removeFromCart,
                          child: Text('ACCEPT'),
                        ),
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
      ),
    );
  }
}
