import 'package:bookzapp/screens/MainScreen.dart';
import 'screens/MyLoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyMain(),
    );
  }
}

class MyMain extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyMain();
  }

}
class _MyMain extends State<MyMain>{



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Bookz"),
        ),
        body:Main()
    );
  }

}

//login form
class Main extends StatefulWidget {
  @override
  MainState createState() {
    return MainState();
  }
}
class MainState extends State<Main> {
  bool _loggedIn;
  String _userName;
  String _password;

  @override
  Widget build(BuildContext context) {
    _loggedIn = true;
    return (_loggedIn)? MainScreen() : MyLoginScreen();
  }
}



