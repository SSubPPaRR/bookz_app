
import 'package:bookzapp/model/Book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatalogSearchList extends StatelessWidget{
  final List<Book> _list;

  CatalogSearchList(this._list);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
      height: 200.0,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: _list.map((book) => Container(
            alignment:  Alignment.topCenter,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            width: 160.0,
            color: Colors.black,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Image.network(book.image),
                //book title container
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child:
                  //book title
                  Text(
                    book.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )).toList()
      ),
    );
  }
}
