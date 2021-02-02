import 'package:bookzapp/Widgets/CatalogSearchList.dart';
import 'package:bookzapp/model/BookSet.dart';
import 'package:bookzapp/model/Utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatalogSearchResult extends StatefulWidget {
  final String query;
  final int sortOption;

  CatalogSearchResult(this.query, this.sortOption);

  @override
  _CatalogSearchResultState createState() => _CatalogSearchResultState();
}

class _CatalogSearchResultState extends State<CatalogSearchResult> {
  Future<BookSet> retrieveSearchedBooks() async {
    var bookSet = await Utilities.fetchBookSet(
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
    print("SO: " + widget.sortOption.toString());
    // if there is nothing being searched
    if (widget.query == "") {
      return Center(child: Text('Please enter a search query'));
    } else {
      //get searched books
      return FutureBuilder(
          future: retrieveSearchedBooks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
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
            } else
              return RefreshIndicator(
                //todo: add ability to load more search results
                child: CatalogSearchList(Utilities.sortBookList(
                    widget.sortOption, snapshot.data.books)),
                onRefresh: () => refresh(),
              );
          });
    }
  }
}
