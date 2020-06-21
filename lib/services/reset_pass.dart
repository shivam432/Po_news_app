import 'package:doenlaod_app/services/auth.dart';
import 'package:flutter/material.dart';

class Resetpassword extends StatefulWidget {
  @override
  _ResetpasswordState createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String error = '';
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reser your password",
          textAlign: TextAlign.left,
        ),
        backgroundColor: Colors.lightBlue,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Reset Password',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email ID",
                      hintText: "Enter your Email ID",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                    validator: (val) => val.isEmpty ? 'Enter the email' : null,
                    onChanged: (val) {
                      setState(() {
                        email = val;
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
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        await _auth.sendthepasswordresetlink(email);
                        setState(() {
                          error = "Go check your email";
                        });
                      } else
                        return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text(error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15.0,
                      ))
                ],
              )),
        ),
      ),
    );
  }
}
