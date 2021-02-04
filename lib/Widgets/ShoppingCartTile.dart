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
      height: 120,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          children: [
            ListTile(
              leading: Image.network(book.image, fit: BoxFit.fitHeight),
              title: Text(book.title),
              trailing: IconButton(
                icon: Icon(Icons.delete,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        void removeFromCart() {
                          String uid = context.read<User>().uid;
                          DocumentReference document = FirebaseFirestore
                              .instance
                              .collection('users')
                              .doc(uid);
                          document
                              .update({
                                'shoppingCart':
                                    FieldValue.arrayRemove([book.isbn])
                              })
                              .then((value) => {
                                    print("ShoppingCart Updated"),
                                  })
                              .catchError((error) => {
                                    print(
                                        "Failed to update ShoppingCart: $error"),
                                  });
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('errorMsg')));
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
            counter()
          ],
        ),
      ),
    );
  }
}

class counter extends StatefulWidget {
  @override
  _counterState createState() => _counterState();
}

class _counterState extends State<counter> {

  int counter = 1;
  void incrementCounter() {
    setState(() {
      if (counter == 99) {
        return null;
      }
      counter++;
    });
  }
  void decrementCounter() {
    setState(() {
      if (counter == 0) {
        return null;
      }
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5)),
              child: GestureDetector(
                  onTap: decrementCounter,
                  child: Icon(
                    Icons.remove_circle,
                    color: Colors.white,
                    size: 50,
                  )),
            ),
            SizedBox(width: 10),
            Container(
                margin: EdgeInsets.only(left: 6, right: 6),
                child: Text(
                  '$counter',
                  style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                )),
            SizedBox(width: 10),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5)),
              child: GestureDetector(
                  onTap: incrementCounter,
                  child: Icon(
                    Icons.add_circle,
                    color: Colors.white,
                    size: 50,
                  )),
            )
          ],
        )
    );
  }
}
