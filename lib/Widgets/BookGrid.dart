import 'package:bookzapp/Widgets/BookBox.dart';
import 'package:bookzapp/model/Book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatalogGrid extends StatelessWidget{
  final String _catGridTitle;
  final List<Book> _list;

  CatalogGrid(this._catGridTitle, this._list);

  @override
  Widget build(BuildContext context) {
    if (_list.isNotEmpty) {
      return Card(
        color: Colors.white60,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Grid title
              Text(
                "  " + _catGridTitle,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                height: 400.0,
                child: GridView.count(
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    //crossAxisSpacing: 10,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    children: _list
                        .map((book) => BookBox(
                              book,
                              width: double.maxFinite,
                            ))
                        .toList()),
              ),
            ],
          ),
        ),
      );
    }
    else{
      return Card(
        color: Colors.purple,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Grid title
              Text(
                "  " + _catGridTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,

                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 80),
                child:Center(
                  child: Text(
                    "No books were found!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
              ,
            ],
          ),
        ),
      );

    }
  }
}
