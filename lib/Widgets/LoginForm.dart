import 'package:bookzapp/model/AuthenticationService.dart';
import 'package:bookzapp/screens/MyRegisterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String email;
  String password;

  //swap to registration screen
  void _changeForm(context) async {
    bool result = false;
    result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyRegisterScreen(),
        ));

    if (result) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text("Account created, please verify email"),
        ),
      );
    }
  }

  //error handling
  void _loginError(String errorCode, BuildContext context) {
    // force snackBar to close before opening a new one
    Scaffold.of(context).removeCurrentSnackBar();

    if (errorCode == 'not-verified') {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 8),
          content: Text('Email not verified'),
          action: SnackBarAction(
              label: 'Verify email',
              onPressed: () {
                print('trying to send verification mail');
                context
                    .read<AuthenticationService>()
                    .sendVerification(email, password);
              }),
        ),
      );
    } else if (errorCode == 'invalid-email') {
      print('Email entered is invalid');
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Email entered is invalid'),
        ),
      );
    } else if (errorCode == 'user-not-found') {
      print('No user found for that email.');
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('No user found for that email.'),
        ),
      );
    } else if (errorCode == 'wrong-password') {
      print('Wrong password provided for that user.');
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Wrong password provided for that user.'),
        ),
      );
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(errorCode),
        ),
      );
    }
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
                        duration: Duration(minutes: 1),
                        content: Text('Processing...'),
                      ),
                    );
                    email = userController.text.trim();
                    password = passController.text.trim();

                    String authError = await context
                        .read<AuthenticationService>()
                        .signIn(email: email, password: password);
                    _loginError(authError, context);
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
