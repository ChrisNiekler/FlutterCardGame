import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wizard/0auth/services/authentication.dart';
import 'package:wizard/gamepage.dart';
import 'package:wizard/ui/ranking_page.dart';

final Map<int, Widget> difficulties = const <int, Widget>{
  0: Text('easy'),
  1: Text('normal'),
  2: Text('crazy'),
};

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.email, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final String email;

  @override
  State<StatefulWidget> createState() => new _HomePageState(this.email);
}

class _HomePageState extends State<HomePage> {
  _HomePageState(this.email);

  final String email;
  int difficulty = 0;

  String getUsername(String email) {
    int end = email.indexOf("@");
    return email.substring(0, end);
  }

  //need to pass it to backendInit.dart
  int playerAmount(int amount) {
    return amount;
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          new FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.grey)),
              onPressed: signOut)
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: "hero",
              child: new Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  new Container(
                    height: 220.0,
                    width: 220.0,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(20.0),
                        color: Color(0xFFB4202A)),
                  ),
                  new Container(
                      height: 200.0,
                      width: 200.0,
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: new Image.asset("images/logo/wizard-icon.png"))
                ],
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "Wizard",
                    style: new TextStyle(fontSize: 30.0),
                  ),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return choosePlayerNumberDialog(context);
                          },
                        );
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("New Game",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GamePage(
                                    amountPlayers: 6, username: email)));
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Continue",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScoreList()));
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Ranking",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () => exit(0),
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Quit",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  AlertDialog choosePlayerNumberDialog(BuildContext context) {
    return AlertDialog(
      title: new Text("How many players"),
      content: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              child: new Text(
                "3 Players",
                style: TextStyle(color: Colors.black26),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GamePage(
                          amountPlayers: 3,
                          username: email,
                          difficulty: difficulty)),
                );
              },
            ),
            new RaisedButton(
              child: new Text(
                "4 Players",
                style: TextStyle(color: Colors.black26),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GamePage(
                          amountPlayers: 4,
                          username: email,
                          difficulty: difficulty)),
                );
              },
            ),
            new RaisedButton(
              child: new Text(
                "5 Players",
                style: TextStyle(color: Colors.black26),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GamePage(
                          amountPlayers: 5,
                          username: email,
                          difficulty: difficulty)),
                );
              },
            ),
            new RaisedButton(
              child: new Text(
                "6 Players",
                style: TextStyle(color: Colors.black26),
              ),
              onPressed: () {
                print("6");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GamePage(
                          amountPlayers: 6,
                          username: email,
                          difficulty: difficulty)),
                );
              },
            ),
            new CupertinoSegmentedControl<int>(
              children: difficulties,
              onValueChanged: (int val) {
                setState(() {
                  difficulty = val;
                });
              },
              borderColor: Colors.black,
              unselectedColor: Colors.lightBlueAccent,
              selectedColor: Colors.blueAccent,
              pressedColor: Colors.grey,
            ),
            new RaisedButton(
              child: new Text(
                "Close",
                style: TextStyle(color: Colors.black26),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
