import 'package:bookzapp/Widgets/CatalogSearchResultGrid.dart';
import 'package:bookzapp/model/BookSet.dart';
import 'package:bookzapp/model/KeepAliveFutureBuilder.dart';
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

    print("SQ: " + widget.query);
    print("SO: " + widget.sortOption.toString());

    // if there is nothing being searched
    if (widget.query == "") {
      return Center(child: Text('Please enter a search query'));
    } else {
      //get searched books
      return Container(
        color: Colors.white60,
        child: ListView.builder(
            addAutomaticKeepAlives: true,
            itemCount: maxPages,
            itemBuilder: (context, index) {
              if (latestPage < index + 1) {
                latestPage = index + 1;
              }
              return KeepAliveFutureBuilder(
                  future: retrieveSearchedBooks(index + 1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * 2,
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: CircularProgressIndicator()));
                    }
                    else if (snapshot.data.error == -1) {
                      return Container(
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.warning_amber_sharp,
                                size: 50,
                              ),
                              Text('Failed to generate module'),
                            ],
                          ));
                    } else {
                      print('latest page: $latestPage');
                      //grid items here
                      return CatalogSearchResultGrid(Utilities.sortBookList(
                          widget.sortOption, snapshot.data.books));
                    }
                  });
            }),
      );
    }
  }
}
