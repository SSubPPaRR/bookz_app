import 'package:bookzapp/model/AuthenticationService.dart';
import 'package:bookzapp/screens/MyRegisterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _changeForm(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyRegisterScreen(),
        ));
  }

  //TODO: implement code handling
  void _loginError(String errorCode) {
    /*if(errorCode == 'invalid-email') {
      print('Email entered is invalid');
    }
    else if (errorCode == 'user-not-found') {
      print('No user found for that email.');
    } else if (errorCode == 'wrong-password') {
      print('Wrong password provided for that user.');
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: Text("Login to Bookz"),
          ),
          TextFormField(
            controller: userController,
            decoration: InputDecoration(labelText: "Username"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter username';
              }
              return null;
            },
          ),
          TextFormField(
            controller: passController,
            decoration: InputDecoration(labelText: "Password"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            buttonPadding: EdgeInsets.all(14),
            children: <Widget>[
              RaisedButton(
                onPressed: () => _changeForm(context),
                child: Text("Register"),
              ),
              RaisedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a SnackBar.
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Processing Data'),
                      ),
                    );

                    String authError = await context
                        .read<AuthenticationService>()
                        .signIn(
                            email: userController.text.trim(),
                            password: passController.text.trim());

                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(authError),
                      ),
                    );
                  }
                },
                child: Text('Submit'),
              )
            ],
          )
        ],
      ),
    );
  }
}
