import 'package:doenlaod_app/services/register.dart';
import 'package:doenlaod_app/services/signin.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showsignin = true;
  void toggleview() {
    setState(() => showsignin = !showsignin);
  }

  @override
  Widget build(BuildContext context) {
    if (showsignin) {
      return SignIn(toggle: toggleview);
    } else {
      return Register(toggle: toggleview);
    }
  }
}
