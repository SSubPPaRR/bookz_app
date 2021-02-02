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
    return SafeArea(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.short_text,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.15,
            width: double.infinity,
            child: Center(
              child: Text(
                "SignUp",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Container(
                      child: Center(
                        child: Text(
                          "P",
                          style: TextStyle(
                            color: Color(0xFF64d0cb),
                            fontSize: 90,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    TextFormField(
                      controller: userController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Email Address",
                        helperStyle: TextStyle(
                          color: Colors.black26,
                        ),
                        prefixIcon: Icon(
                          Icons.mail,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.black26,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: passController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        password = value;
                        if (value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Password",
                        helperStyle: TextStyle(
                          color: Colors.black26,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.black26,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please confirm password';
                        } else if (value != password) {
                          return 'Password does not match, try again!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        helperStyle: TextStyle(
                          color: Colors.black26,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.black26,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: FlatButton(
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
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        color: Color(0xFF7dd7d2),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: OutlineButton(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.black38,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "RETURN TO LOG IN",
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 18,
                          ),
                        ),
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        color: Color(0xFF7dd7d2),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
