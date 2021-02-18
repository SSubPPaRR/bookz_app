import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:bookzapp/model/Book.dart';
import 'package:bookzapp/model/Utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBookScreen extends StatefulWidget {
  final Book book;

  const MyBookScreen({this.book});

  @override
  _MyBookScreenState createState() => _MyBookScreenState();
}

class _MyBookScreenState extends State<MyBookScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.blue,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: Image.network(
                        widget.book.image,
                        height: 180,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.book.title,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.book.authors,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "\$" + widget.book.price.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    _Rating(
                      rating: widget.book.rating,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TabBar(
                      controller: _tabController,
                      indicator: UnderlineTabIndicator(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.5),
                          insets: EdgeInsets.fromLTRB(
                            0.0,
                            0.0,
                            50.0,
                            0.0,
                          )),
                      unselectedLabelStyle: TextStyle(color: Colors.grey[500]),
                      unselectedLabelColor: Colors.grey[500],
                      labelColor: Colors.black,
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      isScrollable: false,
                      labelPadding: EdgeInsets.only(left: 0, right: 20),
                      tabs: [
                        _tabWidget("Description"),
                        _tabWidget("Info"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                        fit: FlexFit.tight,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Container(
                              child: Text(
                                widget.book.desc,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /* title: book.title,
                                subtitle: book.subTitle,
                                publisher: book.publisher,
                                authors: book.authors,
                                rating: book.rating,*/
                                Text(
                                  "Title: " + widget.book.title,
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "Subtitles: " + widget.book.subTitle,
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "Publisher: " + widget.book.publisher,
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "Authors: " + widget.book.authors,
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "Chapters:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                _ChapterList(
                                  chapters: widget.book.pdf,
                                ),
                              ],
                            )),
                          ],
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: _ButtonHandler(widget.book),
    );
  }

  Widget _tabWidget(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

/**/

///rating widget gives filled in stars determined by [rating] / [maxRating]
///[maxRating] = 5 by default
class _Rating extends StatelessWidget {
  final int rating;
  final int maxRating;

  const _Rating({this.rating, this.maxRating = 5});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: List.generate(maxRating, (index) {
          if (index < rating) {
            return Icon(
              Icons.star,
              color: Colors.yellow,
            );
          } else
            return Icon(Icons.star_border);
        }),
      ),
    );
  }
}

class _Chapter extends StatelessWidget {
  final MapEntry e;

  const _Chapter({Key key, this.e}) : super(key: key);

  //support for other links can be added here
  urlFormatter(String s) async {
    print('First link: ' + s.toString());
    if (s.endsWith('.pdf')) {
      return PDFDocument.fromURL(s);
    } else if (s.startsWith('https://www.dbooks.org/')) {
      return PDFDocument.fromURL(await Utilities.getPDFFromDBooks(s));
    } else {
      return 'not-supported';
    }
  }

  //open new route with pdf viewer
  void openPDFViewer(BuildContext context, String s) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FutureBuilder(
                future: urlFormatter(s),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Scaffold(
                      appBar: AppBar(),
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.data == 'not-supported') {
                    return Scaffold(
                      appBar: AppBar(),
                      body: Center(
                        child: Text('Link not yet supported!'),
                      ),
                    );
                  } else {
                    return Scaffold(
                        appBar: AppBar(),
                        body: PDFViewer(document: snapshot.data));
                  }
                })));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(e.key),
      leading: Icon(Icons.picture_as_pdf),
      onTap: () {
        openPDFViewer(context, e.value);
      },
    );
  }
}

class _ChapterList extends StatelessWidget {
  final Map<String, dynamic> chapters;

  const _ChapterList({this.chapters});

  @override
  Widget build(BuildContext context) {
    if (chapters == null) {
      return Text("No chapters where found");
    }
    return ListView(
      shrinkWrap: true,
      children: chapters.entries
          .map((e) => _Chapter(
                e: e,
              ))
          .toList(),
    );
  }
}

class _ButtonHandler extends StatefulWidget {
  final Book book;

  const _ButtonHandler(this.book);

  @override
  __ButtonHandlerState createState() => __ButtonHandlerState(book);
}

class __ButtonHandlerState extends State<_ButtonHandler> {
  bool add = true;
  final Book book;

  __ButtonHandlerState(this.book);

  void showError(context, errorMsg) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
  }

  void swapState() {
    setState(() {
      add = !add;
    });
  }

  @override
  void initState() {
    super.initState();
    List<dynamic> list;
    String uid = context.read<User>().uid;
    DocumentReference document =
        FirebaseFirestore.instance.collection('users').doc(uid);
    document.get().then((value) {
      print('button check: ' + value.get('shoppingCart').toString());
      list = value.get('shoppingCart');

      if (list.contains(book.isbn)) {
        setState(() {
          add = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (add)
        ? FloatingActionButton(
            child: Icon(Icons.add_shopping_cart),
            tooltip: "add to cart",
            onPressed: () {
              String uid = context.read<User>().uid;
              DocumentReference document =
                  FirebaseFirestore.instance.collection('users').doc(uid);
              document
                  .update({
                    'shoppingCart': FieldValue.arrayUnion([book.isbn])
                  })
                  .then((value) => {
                        print("Book added to cart"),
                        showError(context, "Book added to cart"),
                      })
                  .catchError((error) => {
                        print("Failed to update ShoppingCart: $error"),
                        showError(
                            context, "Failed to update ShoppingCart: $error"),
                      });
              swapState();
            })
        : FloatingActionButton(
            child: Icon(Icons.check),
            tooltip: "add to cart",
            onPressed: () {
              String uid = context.read<User>().uid;
              DocumentReference document =
                  FirebaseFirestore.instance.collection('users').doc(uid);
              document
                  .update({
                    'shoppingCart': FieldValue.arrayRemove([book.isbn])
                  })
                  .then((value) => {
                        print("Book removed from cart"),
                        showError(context, "Book removed from cart"),
                      })
                  .catchError((error) => {
                        print("Failed to update ShoppingCart: $error"),
                        showError(
                            context, "Failed to update ShoppingCart: $error"),
                      });
              swapState();
            });
  }
}

/*SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Image.network(book.image),
                  ),
                  Expanded(
                    flex: 3,
                    child: _BookInfo(
                      title: book.title,
                      subtitle: book.subTitle,
                      publisher: book.publisher,
                      authors: book.authors,
                      rating: book.rating,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Description:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(book.desc),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Chapters:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  _ChapterList(
                    chapters: book.pdf,
                  )
                ],
              ),
            ),
          ],
        ),
      ),*/
