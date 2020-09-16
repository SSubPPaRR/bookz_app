import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<LoginFormState>.

  final _formKey = GlobalKey<FormState>();
  String password;
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal:0),
            child: Text("Login to Bookz"),
          ),
          //username
          TextFormField(
            decoration: InputDecoration(
                labelText: "Username"
            ) ,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter username';
              }
              return null;
            },
          ),
          //password
          TextFormField(
            decoration: InputDecoration(
                labelText: "Password"
            ) ,
            validator: (value) {
              password = value;
              if (value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
          ),
          //confirm password
          TextFormField(
            decoration: InputDecoration(
                labelText: "Password"
            ) ,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please confirm password';
              }
              else if(value != password) {
                return 'Password does not match, try again!';
              }
              return null;
            },
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            buttonPadding: EdgeInsets.all(14),
            children: <Widget>[
              RaisedButton(onPressed: null,
                child: Text("Return"),
              ),
              RaisedButton(

                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
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