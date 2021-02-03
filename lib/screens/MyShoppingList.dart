import 'package:bookzapp/Widgets/CheckoutMenu.dart';
import 'package:bookzapp/Widgets/ShoppingCartTile.dart';
import 'package:bookzapp/model/Book.dart';
import 'package:bookzapp/model/Utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class MyShoppingList extends StatefulWidget {
  @override
  _MyShoppingListState createState() => _MyShoppingListState();
}

class _MyShoppingListState extends State<MyShoppingList> {
  Future<List<Book>> getCart(List<dynamic> isbns) async {
    return await Utilities.getListFromISBNS(isbns);
  }

  @override
  Widget build(BuildContext context) {
    String uid = context.watch<User>().uid;
    DocumentReference document =
        FirebaseFirestore.instance.collection('users').doc(uid);
    List<Book> books;
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping cart"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: document.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: SpinKitCubeGrid(
                color: Colors.blue,
                size: 50.0,
              ));
            } else
              return FutureBuilder(
                  future: getCart(snapshot.data.data()['shoppingCart']),
                  builder: (context, snapshot) {
                    books = snapshot.data;

                    print(books);
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: SpinKitCubeGrid(
                        color: Colors.blue,
                        size: 50.0,
                      ));
                    } else {
                      return ListView(
                        children: books
                            .map((book) => MyShoppingCartTile(
                                  book: book,
                                ))
                            .toList(),
                      );
                    }
                  });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return CheckoutMenu(books);
              });
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
