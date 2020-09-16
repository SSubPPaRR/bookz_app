import 'file:///C:/Users/clayt/AndroidStudioProjects/bookz_app/lib/Widgets/LoginPage.dart';
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
        body:Center(

          child: Column(

            mainAxisAlignment:MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
                width: double.infinity,
                child: Card(
                  child: LoginForm(),
                ),
              )
            ],
          ) ,
        )
    );
  }

}

//login form
class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}
class LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return LoginPage();
  }
}

//homepage
class MyHomepage extends StatefulWidget {
  @override
  MyHomepageState createState() {
    return MyHomepageState();
  }
}
class MyHomepageState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return LoginPage();
  }
}

