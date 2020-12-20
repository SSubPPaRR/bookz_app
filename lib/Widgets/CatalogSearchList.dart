
import 'package:bookzapp/model/Book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatalogSearchList extends StatelessWidget{
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
              .map((book) => Container(
                    alignment: Alignment.topCenter,
                    color: Colors.black,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Image.network(book.image),
                        //book title container
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          width: 140,
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
                  ))
              .toList()),
    );
  }
}
