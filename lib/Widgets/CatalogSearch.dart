import 'package:bookzapp/Widgets/CatalogSearchResult.dart';
import 'package:bookzapp/model/Book.dart';
import 'package:flutter/material.dart';

class CatalogSearch extends SearchDelegate<Book> {
  int sortOption = 0;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          tooltip: "Clear",
          onPressed: () {
            query = "";
          }),
      PopupMenuButton(
        icon: Icon(Icons.sort),
        onSelected: (selection) {
          sortOption = selection;
          showSuggestions(context);
          showResults(context);
        },
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              child: Text('New release'),
              value: 0,
            ),
            PopupMenuItem(
              child: Text('Title'),
              value: 1,
            ),
            PopupMenuItem(
              child: Text('ISBN'),
              value: 2,
            ),
            PopupMenuItem(
              child: Text('Price'),
              value: 3,
            ),
          ];
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        tooltip: "Back",
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return CatalogSearchResult(query, sortOption);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
