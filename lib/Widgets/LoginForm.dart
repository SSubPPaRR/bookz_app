import 'package:bookzapp/model/AuthenticationService.dart';
import 'package:bookzapp/screens/MyRegisterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//todo:fix keyboard ui bug
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  String email;
  String password;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

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
    //return login form
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
            height: MediaQuery.of(context).size.width * 0.35,
            width: double.infinity,
            child: Center(
              child: Text(
                "SignIn Page",
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
                          return 'Please enter username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "User Name",
                        helperStyle: TextStyle(
                          color: Colors.black26,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
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
                    Container(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Forgotten your Password",
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 16,
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
                        child: Text(
                          "LOG IN",
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
                        onPressed: () => _changeForm(context),
                        child: Text(
                          "SIGN UP",
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
