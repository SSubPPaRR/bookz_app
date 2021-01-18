import 'dart:convert';

import 'package:http/http.dart' as http;

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
      //error: -1 for connection error
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
      //error: -1 for connection error
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
}
