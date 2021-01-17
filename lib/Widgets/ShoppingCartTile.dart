import 'package:bookzapp/model/Book.dart';
import 'package:bookzapp/screens/MyBookScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            String errorMsg;
            String uid = context.read<User>().uid;
            DocumentReference document =
                FirebaseFirestore.instance.collection('users').doc(uid);
            document
                .update({
                  'shoppingCart': FieldValue.arrayRemove([book.isbn])
                })
                .then((value) => {
                      print("ShoppingCart Updated"),
                      errorMsg = "ShoppingCart Updated",
                    })
                .catchError((error) => {
                      print("Failed to update ShoppingCart: $error"),
                      errorMsg = "Failed to update ShoppingCart: $error",
                    });
            /*Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(errorMsg)));*/
          }, //todo: delete book from list (remove from fireStore & refresh list), popup confirmation?
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
