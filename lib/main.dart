import 'package:doenlaod_app/services/auth.dart';
import 'package:doenlaod_app/user.dart';
import 'package:doenlaod_app/views/homepage.dart';
import 'package:doenlaod_app/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'News_App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: Wrapper(),
      ),
    );
  }
}
