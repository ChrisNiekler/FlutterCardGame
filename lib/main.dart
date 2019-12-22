import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizard/0auth/models/score.dart';
import 'package:wizard/0auth/pages/root_page.dart';
import 'package:wizard/0auth/services/authentication.dart';
import 'package:provider/provider.dart';




import '0auth/services/database.dart';void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Score>>.value(
        value: DatabaseService().score,
      child: new MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: new ThemeData(
            primarySwatch: Colors.lightGreen,
          ),
          home: new RootPage(auth: new Auth())),
    );
  }
}
