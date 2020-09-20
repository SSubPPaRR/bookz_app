import 'package:bookzapp/model/Book.dart';
import 'package:flutter/cupertino.dart';
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
            Text(
              "  " + _catCardTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,

              ),
            ),
            Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
