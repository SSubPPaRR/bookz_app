import 'package:bookzapp/Widgets/BookBox.dart';
import 'package:bookzapp/model/Book.dart';
import 'package:flutter/cupertino.dart';

class Testbooklist extends StatelessWidget{

  final List <Book> cock;

  const Testbooklist({Key key, this.cock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: cock.map((e) => BookBox(e)).toList(),
      ),
    );
  }

}