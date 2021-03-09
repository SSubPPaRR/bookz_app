import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_scraper/web_scraper.dart';

import 'Book.dart';
import 'BookSet.dart';

class Utilities {
  static BookSet parseBookSet(String responseBody) {
    final Map parsed = json.decode(responseBody);
    return BookSet.fromJson(parsed);
  }

  static Future<BookSet> fetchBookSet(String url) async {
    try {
      final response = await http.get(url);
      return parseBookSet(response.body);
    } catch (timeOut) {
      print("Connection timedOut");
      //error: -1 failed to load from api
      return new BookSet(error: -1, total: 0, books: new List<Book>());
    }
  }

  static Book parseBook(String responseBody) {
    final Map parsed = json.decode(responseBody);
    return Book.fromJson(parsed);
  }

  static Future<Book> fetchBook(String isbn13) async {
    print("fetchBook: ");
    String url = "https://api.itbook.store/1.0/books/" + isbn13;
    print("URL: " + url);
    try {
      final response = await http.get(url);
      return parseBook(response.body);
    } catch (error, stack) {
      print("Error occurred retrieving book");
      print(error);
      print(stack);
      //error: -1 failed to load from api
      return new Book(
        error: -1,
        price: null,
        url: null,
        isbn: null,
        title: null,
        image: null,
        subTitle: null,
      );
    }
  }

  static Future<List<Book>> getListFromISBNS(List<dynamic> isbns) async {
    return Future.wait(isbns.map((e) => fetchBook(e.toString())));
  }

  static List<Book> sortBookList(int sortOption, List<Book> list) {
    switch (sortOption) {
      case 0:
        break;

      case 1:
        list.sort((a, b) => a.title.compareTo(b.title));
        break;

      case 2:
        list.sort((a, b) => a.isbn.compareTo(b.isbn));
        break;

      case 3:
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
    }
    return list;
  }

  static Future<String> getPDFFromDBooks(String s) async {
    String path;
    int split;

    if (s.startsWith('https://www.dbooks.org/d/')) {
      split = s.indexOf('/d');
      path = s.substring(split);
    } else {
      path = '/';
      split = s.indexOf('/', 10);
    }

    s = s.substring(0, split);
    final webScraper = WebScraper(s);
    if (await webScraper.loadWebPage(path)) {
      List<Map<String, dynamic>> elements =
          webScraper.getElement('a.btn-down', ['href']);
      print(elements);
      path = elements[0]['attributes']['href']
          .toString()
          .replaceFirst('/d/', '/r/');
      s = s + path;
    }
    return s;
  }

  static Future<bool> valPassword(String password) async {
    User user = FirebaseAuth.instance.currentUser;
    EmailAuthCredential credential =
        EmailAuthProvider.credential(email: user.email, password: password);
    var result = await user.reauthenticateWithCredential(credential);
    return result.user != null;
  }

  static Future<bool> dataConnectionTest() async {
    if (await DataConnectionChecker().hasConnection) {
      return true;
    } else
      return false;
  }

  static Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network, make sure there is actually a net connection.
      return dataConnectionTest();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a WIFI network, make sure there is actually a net connection.
      return dataConnectionTest();
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      return false;
    }
  }

  static Widget showNoConnectionWidget(BuildContext context,
      {Widget noConnWidget, Widget widget}) {
    return FutureBuilder(
        future: checkConnection(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.data) {
              return noConnWidget;
            } else
              return widget;
          }
          return Center(
            child: Text('s'),
          );
        });
  }
}
