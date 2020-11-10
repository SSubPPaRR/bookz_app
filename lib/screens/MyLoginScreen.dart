import 'package:flutter/material.dart';

class MyLoginScreen extends StatefulWidget {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<LoginFormState>.

  @override
  _MyLoginScreenState createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _login = true;
  String password;

  void _changeForm() {
    setState(() {
      _login =! _login;
      print('changed form');
    });

  }

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
                    child: (_login)
                        ? Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
                            child: Text("Login to Bookz"),
                          ),
                          TextFormField(
                            decoration:
                            InputDecoration(labelText: "Username"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter username';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration:
                            InputDecoration(labelText: "Password"),
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
                                onPressed: _changeForm,
                                child: Text("Register"),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false
                                  // otherwise.
                                  if (_formKey.currentState.validate()) {
                                    // If the form is valid, display a Snackbar.
                                    Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                            Text('Processing Data')));
                                  }
                                  Navigator.pushReplacementNamed(context, "/main");
                                },
                                child: Text('Submit'),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                        : Form(//registration
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
                            child: Text("Register for Bookz"),
                          ),
                          //username
                          TextFormField(
                            decoration:
                            InputDecoration(labelText: "Username"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter username';
                              }
                              return null;
                            },
                          ),
                          //password
                          TextFormField(
                            decoration:
                            InputDecoration(labelText: "Password"),
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
                                labelText: "Confirm password"),
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
                            alignment: MainAxisAlignment.spaceBetween,
                            buttonPadding: EdgeInsets.all(14),
                            children: <Widget>[
                              RaisedButton(
                                onPressed: _changeForm,
                                child: Text("Return"),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false
                                  // otherwise.
                                  if (_formKey.currentState.validate()) {
                                    // If the form is valid, display a Snackbar.
                                    Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                            Text('Processing Data')));
                                  }
                                },
                                child: Text('Submit'),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
        )
    );
  }
}
