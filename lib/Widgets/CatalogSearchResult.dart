import 'package:bookzapp/Widgets/CatalogSearchResultGrid.dart';
import 'package:bookzapp/model/BookSet.dart';
import 'package:bookzapp/model/Utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CatalogSearchResult extends StatefulWidget {
  final String query;
  final int sortOption;

  CatalogSearchResult(this.query, this.sortOption);

  @override
  _CatalogSearchResultState createState() => _CatalogSearchResultState();
}

class _CatalogSearchResultState extends State<CatalogSearchResult> {
  int maxPages;
  int latestPage = 1;

  Future<BookSet> retrieveSearchedBooks(int currentPage) async {
    var bookSet = await Utilities.fetchBookSet(
        "https://api.itbook.store/1.0/search/" +
            widget.query +
            "/$currentPage");
    return bookSet;
  }

  void setMaxPages() async {
    maxPages = ((await retrieveSearchedBooks(1)).total / 10).round();
    print('maxPages: $maxPages');
  }

  @override
  void initState() {
    setMaxPages();
    super.initState();
  }

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
      return Container(
        color: Colors.deepOrange,
        child: ListView.builder(
            addAutomaticKeepAlives: true,
            itemCount: maxPages,
            itemBuilder: (context, index) {
              if (latestPage < index + 1) {
                latestPage = index + 1;
              }
              return FutureBuilder(
                  future: retrieveSearchedBooks(index + 1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * 2,
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: SpinKitCubeGrid(
                                color: Colors.blue,
                                size: 50.0,
                              )));
                    }
                    // this part might need to be reworked
                    else if (snapshot.data.error == -1) {
                      return Container(
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
                          ));
                    } else {
                      print('latest page: $latestPage');
                      //grid items here
                      return CatalogSearchResultGrid(snapshot.data.books);
                    }
                  });
            }),
      );
    }
  }
}
