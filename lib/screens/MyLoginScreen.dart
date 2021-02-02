import 'package:bookzapp/Widgets/LoginForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return login form
    return Scaffold(
      backgroundColor: Color(0xFF7dd7d2),
      body: LoginForm(),
    );
  }
}
