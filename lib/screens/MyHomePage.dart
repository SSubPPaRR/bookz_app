import 'dart:convert';
import 'dart:math';
import 'package:bookzapp/Widgets/CatalogGrid.dart';
import 'package:bookzapp/Widgets/CatalogCard.dart';
import 'package:bookzapp/model/Book.dart';
import 'package:bookzapp/model/BookSet.dart';
import 'package:flutter/cupertino.dart';
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

  String topic;
  List<String> topics = ["java","HTML","Python"];

  //these don't change, used in conjunction
  BookSet parseBookSet(String responseBody) {
    final Map parsed = json.decode(responseBody);
    return BookSet.fromJson(parsed);
  }
  Future<BookSet> fetchBookSet(String url) async{
      try {
        final response = await http.get(url);
        return parseBookSet(response.body);
      }
      catch(timeOut){
        print("Connection timedOut");
        return null; //new BookSet(error: 0,total: 0,books: new List<Book>());
      }
  }

  //returns list of books based on today's topics
  Future<Map<String,List<Book>>> retrieveDailyBooks() async {
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

  // returns list of newly released books
  Future<List<Book>> retrieveNewReleases() async{
    var bookSet = await fetchBookSet("https://api.itbook.store/1.0/new");
    List<Book> bookList = bookSet.books;
    return bookList;
  }

  //returns map containing list of books for various categories
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

  //load error
  Widget catalogCardLoad(a){
    if(a == null){
      return
      Container(
        color: Colors.red,
        child: ListView(
          children:<Widget>[
            Center(
              child: Container(
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.signal_wifi_off,
                      size: 50,
                    ),
                    Text('No connection, reload to try again'),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

    }
    else{
      return
      ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          //new releases
          CatalogCard("New releases",a['NewRelease']),
          //catalog grid test random daily books
          CatalogGrid("Books about " + topic, a[topic]),
        ]
      );
    }
  }

  // reload new releases
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Map<String,List<Book>>>(
      future: getAllBooks(),
      builder:(context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return  Center(child: Text('Please wait Homepage is loading...'));
        }else return RefreshIndicator(child:

          catalogCardLoad(snapshot.data),

         onRefresh:() =>  updateWidgets());
      } ,
    );
  }
}