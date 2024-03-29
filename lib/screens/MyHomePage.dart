import 'package:bookzapp/Widgets/BookCard.dart';
import 'package:bookzapp/Widgets/BookGrid.dart';
import 'package:bookzapp/Widgets/ReloadableNoConnectionScreen.dart';
import 'package:bookzapp/model/BookSet.dart';
import 'package:bookzapp/model/Utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String topic;

  void setTopic() {
    DocumentReference document =
        FirebaseFirestore.instance.collection('main').doc('daily');

    document.get().then((value) {
      List<dynamic> list = value.get('topics');
      int index = DateTime.now().day % list.length;
      topic = list.elementAt(index);
    });
  }

  //returns list of books based on today's topics
  Future<Map<String, BookSet>> retrieveDailyBooks() async {
    var bookSet = await Utilities.fetchBookSet(
        "https://api.itbook.store/1.0/search/" + topic);

    Map<String, BookSet> dailyBooks = {
      topic: bookSet,
    };
    return dailyBooks;
  }

  // returns list of newly released books
  Future<BookSet> retrieveNewReleases() async {
    var bookSet =
        await Utilities.fetchBookSet("https://api.itbook.store/1.0/new");
    return bookSet;
  }

  //returns map containing list of books for various categories
  Future<Map<String, BookSet>> getAllBooks() async {
    Map<String, BookSet> catalogBookMap = new Map();

    catalogBookMap['NewRelease'] = await retrieveNewReleases();
    catalogBookMap.addAll(await retrieveDailyBooks());

    return catalogBookMap;
  }

  Future<void> updateWidgets() async {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    setTopic();

    return Utilities.showNoConnectionWidget(
      context,
      noConnWidget: ReloadableNoConnectionScreen(
        func: updateWidgets,
      ),
      widget: FutureBuilder<Map<String, BookSet>>(
        future: getAllBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: SpinKitCubeGrid(
              color: Colors.blue,
              size: 50.0,
            ));
          } else if (snapshot.data['NewRelease'].error == -1) {
            return RefreshIndicator(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overScroll) {
                    overScroll.disallowGlow();
                    return true;
                  },
                  child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: <Widget>[
                        Center(
                          child: Text('Error occurred while making modules!'),
                        ),
                        //new releases
                        CatalogCard("New releases", []),
                        //catalog grid test random daily books
                        CatalogGrid("Books about " + topic, []),
                      ]),
                ),
                onRefresh: () => updateWidgets());
          } else {
            return RefreshIndicator(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: <Widget>[
                      //new releases
                      CatalogCard(
                          "New releases", snapshot.data['NewRelease'].books),
                      //catalog grid test random daily books
                      CatalogGrid(
                          "Books about " + topic, snapshot.data[topic].books),
                    ]),
                onRefresh: () => updateWidgets());
          }
        },
      ),
    );
  }
}