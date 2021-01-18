import 'package:bookzapp/model/Book.dart';
import 'package:flutter/cupertino.dart';

class BookSet{
  int total,error;
  List<Book> books;

  BookSet({
    @required this.error,
    @required this.total,
    @required this.books,
  });

  List<Book> getXBooks(int amount) {
    if (amount < books.length) {
      return books.getRange(0, amount - 1);
    }
    return getBooks();
  }

  List<Book> getBooks() {
    return books;
  }

  @override
  String toString() {
    return 'BookSet{total: $total, error: $error, books: $books}';
  }

  factory BookSet.fromJson(Map<String, dynamic> json) {
    return BookSet(
      error: int.parse(json['error']),
      total: int.parse(json['total']),
      books: List<Book>.from(
          json['books'].map((s) => Book.fromJsonForBookSet(s)).toList()),
    );
  }
}
