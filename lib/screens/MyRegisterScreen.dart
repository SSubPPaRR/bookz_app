import 'package:bookzapp/Widgets/RegistrationForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7dd7d2),
      body: RegistrationForm(),
    );
  }
}
