import 'package:bookzapp/model/AuthenticationService.dart';
import 'package:bookzapp/model/Utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nPass = new TextEditingController();
  final TextEditingController cPass = new TextEditingController();

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
    BuildContext scaffoldContext = context;
    String password;
    bool checkCurrentPasswordValid = true;
    return SingleChildScrollView(
      child: Center(
        child: Container(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: FlatButton(
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Color(0xFFF5F6f9),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Reset password?'),
                            content: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: TextFormField(
                                      controller: cPass,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter current password';
                                        } else if (!checkCurrentPasswordValid) {
                                          return 'Incorrect password';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Current password',
                                        border: OutlineInputBorder(),
                                        suffixIcon: Icon(
                                          Icons.remove_red_eye_rounded,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: TextFormField(
                                      controller: nPass,
                                      validator: (value) {
                                        password = value;
                                        if (value.isEmpty) {
                                          return 'Please enter new password';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'New password',
                                        border: OutlineInputBorder(),
                                        suffixIcon: Icon(
                                          Icons.remove_red_eye_rounded,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please confirm password';
                                        } else if (value != password) {
                                          return 'Password does not match, try again!';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Confirm password',
                                        border: OutlineInputBorder(),
                                        suffixIcon: Icon(
                                          Icons.remove_red_eye_rounded,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              FlatButton(
                                textColor: Color(0xFF6200EE),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  nPass.clear();
                                  cPass.clear();
                                },
                                child: Text('CANCEL'),
                              ),
                              FlatButton(
                                textColor: Color(0xFF6200EE),
                                onPressed: () async {
                                  User user = FirebaseAuth.instance.currentUser;
                                  var result;
                                  try {
                                    result =
                                        await Utilities.valPassword(cPass.text);
                                  } catch (e) {
                                    print(e);
                                    result = false;
                                  }
                                  checkCurrentPasswordValid = result;
                                  if (_formKey.currentState.validate()) {
                                    // If the form is valid, display a SnackBar.
                                    Scaffold.of(scaffoldContext).showSnackBar(
                                        SnackBar(
                                            content: Text('Processing Data')));

                                    try {
                                      user.updatePassword(nPass.text);
                                      Scaffold.of(scaffoldContext)
                                          .removeCurrentSnackBar();
                                      Scaffold.of(scaffoldContext).showSnackBar(
                                          SnackBar(
                                              backgroundColor: Colors.green,
                                              content:
                                                  Text("password changed")));
                                      Navigator.of(context).pop();
                                      nPass.clear();
                                      cPass.clear();
                                    } catch (e) {
                                      print(e.toString());
                                      Scaffold.of(scaffoldContext)
                                          .removeCurrentSnackBar();
                                      Scaffold.of(scaffoldContext).showSnackBar(
                                          SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(e.toString())));
                                    }
                                  }
                                },
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
        ),
      ),
    );
  }
}
