import 'package:bookzapp/Widgets/CatalogGrid.dart';
import 'package:bookzapp/model/Book.dart';
import 'file:///C:/Users/clayt/AndroidStudioProjects/bookz_app/lib/Widgets/CatalogCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatelessWidget{
  final List<Book> _newRelease =[
    Book(
      title:"this is a test book number 1 with a super long title",
      subTitle: "here is the subtitle",
      isbn: 9781484206485,
      price: 32.04,
      image: "https://itbook.store/img/books/9781484206485.png",
      url: "https://itbook.store/books/9781484206485"
    ),
    Book(
        title:"this is a test book",
        subTitle: "here is the subtitle",
        isbn: 9781484206485,
        price: 32.04,
        image: "https://itbook.store/img/books/9781484206485.png",
        url: "https://itbook.store/books/9781484206485"
    ),
    Book(
        title:"this is a test book",
        subTitle: "here is the subtitle",
        isbn: 9781484206485,
        price: 32.04,
        image: "https://itbook.store/img/books/9781484206485.png",
        url: "https://itbook.store/books/9781484206485"
    )
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: <Widget>[

        //new releases
        CatalogCard("New releases",_newRelease),

        // random books
       /* Card(
          color: Colors.purple,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("this section"),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  height: 200.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: 160.0,
                        color: Colors.red,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: 160.0,
                        color: Colors.blue,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: 160.0,
                        color: Colors.green,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: 160.0,
                        color: Colors.yellow,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: 160.0,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),*/

      //catalog grid test
        CatalogGrid("test grid", _newRelease)

      ],
    );
  }

}