import 'dart:convert';
import 'dart:math';
import 'package:bookzapp/Widgets/CatalogGrid.dart';
import 'package:bookzapp/Widgets/CatalogCard.dart';
import 'package:bookzapp/model/Book.dart';
import 'package:bookzapp/model/BookSet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 /* List<Book> _newReleaseTest = [
    Book(
      title:"this is a test book number 1 with a super long title",
      subTitle: "here is the subtitle",
      isbn: 9781484206485,
      price: 32.04,
      image: "https://itbook.store/img/books/9781484206485.png",
      url: "https://itbook.store/books/9781484206485"
    ),
    Book(
        title:"this is a test book",
        subTitle: "here is the subtitle",
        isbn: 9781484206485,
        price: 32.04,
        image: "https://itbook.store/img/books/9781484206485.png",
        url: "https://itbook.store/books/9781484206485"
    ),
    Book(
        title:"this is a test book",
        subTitle: "here is the subtitle",
        isbn: 9781484206485,
        price: 32.04,
        image: "https://itbook.store/img/books/9781484206485.png",
        url: "https://itbook.store/books/9781484206485"
    )
  ];*/

  String topic = "test grid";
  List<String> topics = ["java","HTML","Python"];


  BookSet parseBookSet(String responseBody) {
    final Map parsed = json.decode(responseBody);
    return BookSet.fromJson(parsed);
  }
  Future<BookSet> fetchBookSet(String url) async{
    final response = await http.get(url);
    return parseBookSet(response.body);
  }


  Future<List<Book>> retrieveNewReleases() async{
    var bookSet = await fetchBookSet("https://api.itbook.store/1.0/new");
    List<Book> bookList = bookSet.books;
    return bookList;
  }
  Future<Map<String,List<Book>>> retrieveDailyBooks() async{
    int rand = new Random().nextInt(topics.length);
    topic = topics.elementAt(rand);
    var bookSet = await fetchBookSet("https://api.itbook.store/1.0/search/" + topic);
    List<Book> bookList = bookSet.books;
    Map<String,List<Book>> dailyBooks = {
      topic: bookList,
    };
    print(dailyBooks);
    return dailyBooks;

  }
  Future<Map<String,List<Book>>> getAllBooks() async {
    Map<String,List<Book>> catalogBookMap = new Map();

    catalogBookMap['NewRelease'] = await retrieveNewReleases();
    catalogBookMap.addAll(await retrieveDailyBooks());

    return catalogBookMap;
  }

  Future<void> updateWidgets() async{
    setState(() {

    });
  }


  // reload new releases
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Map<String,List<Book>>>(
      future: getAllBooks(),
      builder:(context, snapshot) {
        if( snapshot.connectionState == ConnectionState.waiting){
          return  Center(child: Text('Please wait Homepage is loading...'));
        }else return RefreshIndicator(child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget>[

            //new releases
            CatalogCard("New releases",snapshot.data['NewRelease']),
            // random books
            /* Card(
          color: Colors.purple,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("this section"),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  height: 200.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: 160.0,
                        color: Colors.red,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: 160.0,
                        color: Colors.blue,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: 160.0,
                        color: Colors.green,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: 160.0,
                        color: Colors.yellow,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: 160.0,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),*/

            //catalog grid test
            CatalogGrid("Books about " + topic, snapshot.data[topic])
          ],
        ), onRefresh:() =>  updateWidgets());
      } ,
    );
  }
}