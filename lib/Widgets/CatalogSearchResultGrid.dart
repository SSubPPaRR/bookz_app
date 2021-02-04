import 'package:bookzapp/model/Book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BookBox.dart';

class CatalogSearchResultGrid extends StatelessWidget {
  final List<Book> _list;

  CatalogSearchResultGrid(this._list);

  @override
  Widget build(BuildContext context) {
    // final orientation = MediaQuery.of(context).orientation;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          //(orientation == Orientation.portrait) ? 2 : 3
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
