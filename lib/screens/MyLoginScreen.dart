import 'package:bookzapp/Widgets/LoginForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLoginScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    //return login form
    return Scaffold(
        appBar: AppBar(
          title: Text("Bookz"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
                width: double.infinity,
                child: Card(
                  child: LoginForm(),
                ),
              ),
            ],
          ),
        ));
  }
}
