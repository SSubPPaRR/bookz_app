import 'dart:convert';
import 'package:bookzapp/model/Book.dart';
import 'package:bookzapp/model/CatalogCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyCatalog extends StatelessWidget{
  final List<Book> _newRelease =[
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
/*
  Future<http.Response> _cat1 () async {
    return http.get("https://api.itbook.store/1.0/new");
  }
*/
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: <Widget>[
        //new releases
        Card(
          color: Colors.purple,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("New releases"),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  height: 200.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        alignment:  Alignment.topCenter,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: 160.0,
                        color: Colors.red,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            Image.network("https://itbook.store/img/books/9781484211830.png",),
                            Container(
                              margin: EdgeInsets.fromLTRB(4, 4, 4, 0),
                              child: Text("Title goes hereeeee eeeeeeee eeeeeeeee eeeeeeeeeeeeeee",
                                overflow: TextOverflow.ellipsis,
                              )
                              ,
                            )
                          ],
                        ),
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
        ),
        // random books
        Card(
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
        ),
        //CatalogCard test
        CatalogCard("CatalogCard test",_newRelease),

      ],
    );
  }

}