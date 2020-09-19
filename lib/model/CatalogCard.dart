import 'package:bookzapp/model/Book.dart';
import 'package:flutter/material.dart';

class CatalogCard extends StatelessWidget {
  final String _catCardTitle;
  final List<Book> _list;
  CatalogCard(this._catCardTitle,this._list);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_catCardTitle),
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              height: 200.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _list.map((book) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: 160.0,
                  color: Colors.red,
                  child: Image.network(book.image),
                )).toList()
              ),
            ),
          ],
        ),
      ),
    );
  }
}
