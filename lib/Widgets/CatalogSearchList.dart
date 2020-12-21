import 'package:bookzapp/model/Book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BookBox.dart';

class CatalogSearchList extends StatelessWidget {
  final List<Book> _list;

  CatalogSearchList(this._list);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      color: Colors.deepOrange,
      child: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: EdgeInsets.symmetric(horizontal: 5),
          children: _list
              .map((book) => BookBox(
                    book,
                    width: double.maxFinite,
                  ))
              .toList()),
    );
  }
}
