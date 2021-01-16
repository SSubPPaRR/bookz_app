import 'package:bookzapp/screens/MyLoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.mail_outline),
            Text(
              'Please verify email address',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            RaisedButton(
              child: Text('Take me to login'),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyLoginScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
