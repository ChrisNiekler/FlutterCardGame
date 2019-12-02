import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizard/ui/playing_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Wizard',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GamePage());
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Container(
                color: Colors.green,
              ),
            ),
            Expanded(
              flex: 60,
              child: Container(
                color: Colors.blue,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              color: Colors.yellow,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.yellow.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 30,
                      child: Container(
                        color: Colors.purple,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        color: Colors.teal,
                                        child: Center(
                                          child: PlayingCard("3hearts"),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.orange,
                                        child: Center(
                                          child: PlayingCard("2hearts"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.tealAccent,
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: PlayingCard("7hearts"),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.blue,
                                        child: Center(
                                          child: PlayingCard("1hearts"),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.black,
                                        child: Center(
                                          child: PlayingCard("6hearts"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.teal.shade400,
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        color: Colors.teal,
                                        child: Center(
                                          child: PlayingCard("14hearts"),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.orange,
                                        child: Center(
                                          child: PlayingCard("0hearts"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        color: Colors.pink,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 15,
              child: Container(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
