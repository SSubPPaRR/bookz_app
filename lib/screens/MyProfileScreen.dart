import 'package:bookzapp/model/AuthenticationService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen();

  textAndFont(double fontSize, String text) {
    return Center(
      child: SizedBox(
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("lib\\images\\profile-background.png"),
        fit: BoxFit.cover,
      )),
      child: Column(
        children: [
          SizedBox(height: 100),
          textAndFont(50, "Welcome"),
          textAndFont(30, context.watch<User>().email),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: FlatButton(
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Color(0xFFF5F6f9),
              onPressed: () {
                //todo: implement change password
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Reset password?'),
                        content: Column(),
                        actions: [
                          FlatButton(
                            textColor: Color(0xFF6200EE),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('CANCEL'),
                          ),
                          FlatButton(
                            textColor: Color(0xFF6200EE),
                            onPressed: () {},
                            child: Text('ACCEPT'),
                          ),
                        ],
                      );
                    });
              },
              child: Row(
                children: [
                  Icon(Icons.lock_outline),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      "Change password",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: FlatButton(
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Color(0xFFF5F6f9),
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              child: Row(
                children: [
                  Icon(Icons.exit_to_app),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      "Logout",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
