import 'package:cached_network_image/cached_network_image.dart';
import 'package:doenlaod_app/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggle;
  Register({this.toggle});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  final FocusNode _usernamefocus = FocusNode();
  final FocusNode _passfocus = FocusNode();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  bool show_pass = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator()
        : Scaffold(
            backgroundColor: Colors.blueAccent,
            appBar: AppBar(
                backgroundColor: Colors.lightBlue,
                elevation: 0.0,
                title: Text('Register to News++'),
                actions: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.person_outline),
                    label: Text('Sign_in'),
                    onPressed: () {
                      widget.toggle();
                    },
                  )
                ]),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email ID",
                          hintText: "Enter your Email ID",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        textInputAction: TextInputAction.next,
                        focusNode: _usernamefocus,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(
                              context, _usernamefocus, _passfocus);
                        },
                        validator: (val) =>
                            val.isEmpty ? 'Enter the email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "password",
                            hintText: "Enter your password",
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                            suffixIcon: IconButton(
                              icon: show_pass
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                              color: Colors.black,
                              onPressed: () {
                                setState(() {
                                  show_pass = !show_pass;
                                });
                              },
                            )),
                        textInputAction: TextInputAction.done,
                        focusNode: _passfocus,
                        onFieldSubmitted: (value) {
                          _passfocus.unfocus();
                        },
                        validator: (val) =>
                            val.length < 6 ? 'Password is too short' : null,
                        obscureText: !show_pass,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30),
                        ),
                        color: Colors.black,
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .registerwithemailndpassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'please provide a valid email-id';
                              });
                            }
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 15),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 25.0),
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            new Expanded(
                              child: new Container(
                                margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.25)),
                              ),
                            ),
                            Text(
                              "OR CONNECT WITH",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            new Expanded(
                              child: new Container(
                                margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.25)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30),
                        ),
                        color: Colors.white,
                        child: new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://blog.hubspot.com/hubfs/image8-2.jpg',
                                height: 18,
                                width: 18,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 8.0),
                                child: new Text(
                                  "Register with Google",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                        onPressed: () async {
                          dynamic result = await _auth.signinwithgoogle();
                          if (result == null) {
                            setState(() {
                              error =
                                  'could not sign in with those credentianls';
                              loading = false;
                            });
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Text(error,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15.0,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

_fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
