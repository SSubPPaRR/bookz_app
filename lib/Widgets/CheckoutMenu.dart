import 'package:bookzapp/model/Book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckoutMenu extends StatelessWidget {
  final List<Book> books;

  CheckoutMenu(this.books);

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    books.forEach((element) {
      totalPrice += element.price;
    });
    return Container(
      height: 430,
      color: Colors.blueGrey,
      child: Column(
        children: <Widget>[
          //handle
          Container(
            height: 30,
            color: Colors.blueAccent,
            child: Center(
              child: Icon(
                Icons.drag_handle,
                color: Colors.black26,
              ),
            ),
          ),
          //list of books
          Expanded(
            child: ListView(
              children: books
                  .map((book) => ListTile(
                        title: Text(book.title),
                        trailing: Text('\$' + book.price.toStringAsFixed(2)),
                      ))
                  .toList(),
            ),
          ),
          Divider(),
          //Total price
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Total price:'),
                  Text('\$' + totalPrice.toStringAsFixed(2)),
                ],
              ),
            ),
            height: 50,
          ),
          Divider(),
          //Purchase button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: null,
                  child: Text('Purchase'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
