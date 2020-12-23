import 'package:bookzapp/model/AuthenticationService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyLoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  void _changeForm() {}

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 0),
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
                              onPressed: _changeForm,
                              child: Text("Register"),
                            ),
                            RaisedButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, or false
                                // otherwise.
                                if (_formKey.currentState.validate()) {
                                  // If the form is valid, display a SnackBar.
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Processing Data')));
                                }
                                context.read<AuthenticationService>().signIn(
                                    email: userController.text.trim(),
                                    password: passController.text.trim());
                              },
                              child: Text('Submit'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
