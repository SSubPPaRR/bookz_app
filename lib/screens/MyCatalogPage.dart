import 'dart:convert';
import 'package:bookzapp/Widgets/CatalogSearchList.dart';
import 'package:bookzapp/model/Book.dart';
import 'package:bookzapp/model/BookSet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyCatalogPage extends StatefulWidget {
  final String query;

  MyCatalogPage(this.query);

  @override
  _MyCatalogPageState createState() => _MyCatalogPageState();
}

class _MyCatalogPageState extends State<MyCatalogPage> {
  BookSet parseBookSet(String responseBody) {
    final Map parsed = json.decode(responseBody);
    return BookSet.fromJson(parsed);
  }

  Future<BookSet> fetchBookSet(String url) async {
    try {
      final response = await http.get(url);
      return parseBookSet(response.body);
    } catch (timeOut) {
      print("Connection timed out/Search query error");
      //error: -1 for connection error
      return new BookSet(error: -1, total: 0, books: new List<Book>());
    }
  }

  Future<BookSet> retrieveSearchedBooks() async {
    var bookSet = await fetchBookSet(
        "https://api.itbook.store/1.0/search/" + widget.query);
    return bookSet;
  }

  Future<void> refresh() async {
    setState(() {
      retrieveSearchedBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    // calculate height for search result widget
    final bodyHeight = MediaQuery.of(context).size.height -
        kToolbarHeight -
        kBottomNavigationBarHeight -
        kTextTabBarHeight;

    print("SQ: " + widget.query);

    // if there is nothing being searched
    if (widget.query == "") {
      return Center(child: Text('Please enter a search query'));
    } else {
      //get searched books
      return FutureBuilder(
          future: retrieveSearchedBooks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text('Please wait catalog is loading...'));
            } else if (snapshot.data.error == -1) {
              return RefreshIndicator(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification:
                          (OverscrollIndicatorNotification overScroll) {
                        overScroll.disallowGlow();
                        return true;
                      },
                      child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Container(
                              alignment: Alignment.center,
                              color: Colors.red,
                              height: bodyHeight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.signal_wifi_off,
                                    size: 50,
                                  ),
                                  Text('No connection, reload to try again'),
                                ],
                              )))),
                  onRefresh: () => refresh());
            }
            else
              return RefreshIndicator(
                child: CatalogSearchList(snapshot.data.books),
                onRefresh: () => refresh(),
              );
          });
    }
  }
}
