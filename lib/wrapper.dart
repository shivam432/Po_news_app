import 'package:doenlaod_app/services/authentication.dart';
import 'package:doenlaod_app/user.dart';
import 'package:doenlaod_app/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    return user == null ? Authenticate() : HomePage();
  }
}
