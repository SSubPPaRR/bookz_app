import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:bookzapp/model/Book.dart';
import 'package:bookzapp/model/Utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBookScreen extends StatelessWidget {
  final Book book;

  const MyBookScreen({this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
      ),
      floatingActionButton: _ButtonHandler(book),
    );
  }
}

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

class _BookInfo extends StatelessWidget {
  const _BookInfo({
    Key key,
    this.title,
    this.subtitle,
    this.publisher,
    this.authors,
    this.rating,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String publisher;
  final String authors;
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 16.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 13.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            authors,
            style: const TextStyle(fontSize: 12.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            publisher,
            style: const TextStyle(fontSize: 12.0),
          ),
          _Rating(
            rating: rating,
          )
        ],
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
            child: Icon(Icons.add),
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
