import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizard/0auth/pages/root_page.dart';
import 'package:wizard/0auth/services/authentication.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Wizard',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.green,
        ),
        home: new RootPage(auth: new Auth()));
  }
}
