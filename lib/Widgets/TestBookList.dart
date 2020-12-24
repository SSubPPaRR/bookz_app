import 'package:bookzapp/Widgets/BookBox.dart';
import 'package:bookzapp/model/Book.dart';
import 'package:flutter/cupertino.dart';

class TestBookList extends StatelessWidget{

  final List <Book> cock;

  const TestBookList({Key key, this.cock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: cock.map((e) => BookBox(e)).toList(),
      ),
    );
  }

}