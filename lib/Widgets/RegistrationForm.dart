import 'package:bookzapp/model/AuthenticationService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController userController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  void _registerError(String errorCode, context) {
    if (errorCode == "signed-up") {
      // make snackBar appear on the login page after popping navigation
      Navigator.pop(context, true);
    } else if (errorCode == 'invalid-email') {
      print('Email entered is invalid');
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Entered email is invalid'),
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
    String password;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: Text("Register for Bookz"),
          ),

          //Email field
          TextFormField(
            decoration: InputDecoration(labelText: "Email"),
            controller: userController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter username';
              }
              return null;
            },
          ),

          //password field
          TextFormField(
            decoration: InputDecoration(labelText: "Password"),
            controller: passController,
            validator: (value) {
              password = value;
              if (value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
          ),

          //confirm password field
          TextFormField(
            decoration: InputDecoration(labelText: "Confirm password"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please confirm password';
              } else if (value != password) {
                return 'Password does not match, try again!';
              }
              return null;
            },
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            buttonPadding: EdgeInsets.all(14),
            children: <Widget>[
              RaisedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a SnackBar.
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));

                    String authError = await context
                        .read<AuthenticationService>()
                        .signUp(
                            email: userController.text.trim(),
                            password: passController.text.trim());

                    _registerError(authError, context);
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
