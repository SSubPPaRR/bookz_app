import 'package:bookzapp/model/AuthenticationService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Index 2: Profile',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        RaisedButton(
          onPressed: () {
            //context.read<AuthenticationService>().signOut();
          },
          child: Text("Sign out"),
        )
      ],
    );
  }
}
