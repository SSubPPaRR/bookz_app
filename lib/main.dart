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
      initialRoute: "/",
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => MyLoginScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/main': (context) => MainScreen(),
      },
    );
  }
}

//main
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

    return MyLoginScreen();
  }
}



