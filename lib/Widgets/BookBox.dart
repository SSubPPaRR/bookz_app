import 'package:bookzapp/model/Book.dart';
import 'package:bookzapp/model/Utilities.dart';
import 'package:bookzapp/screens/MyBookScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';

/// creates tap-able widget for [book]
/// [width] specifies widget width, if no width is specified then 160.00 is used by default
/// since there is missing data for book due to the nature of how this class is used we need to look up the book independently from the API before loading MyBookScreen
class BookBox extends StatelessWidget {
  final Book book;
  final double width;

  BookBox(this.book, {this.width = 160.0});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        width: width,
        decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(
              color: Colors.lightBlueAccent,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(15),
            gradient: new LinearGradient(
              colors: [Colors.white70, Colors.white],
              begin: Alignment.centerRight,
              end: new Alignment(-1.0, -1.0),
            ),
            boxShadow: [
              new BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
              )
            ]),
        //color of the shits
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            FadeInImage.memoryNetwork(
                placeholder: kTransparentImage, image: book.image),
            //book title container
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child:
                  //book title
                  Text(
                book.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned.fill(
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  print("Open book screen: " + book.isbn.toString());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FutureBuilder(
                              future: Utilities.fetchBook(book.isbn.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Scaffold(
                                    appBar: AppBar(
                                      leading: Icon(Icons.arrow_back),
                                    ),
                                    body: Center(
                                      child: SpinKitCubeGrid(
                                        color: Colors.blue,
                                        size: 50.0,
                                      ),
                                    ),
                                  );
                                }
                                return MyBookScreen(
                                  book: snapshot.data,
                                );
                              })));
                },
              ))),
    ]);
  }
}
