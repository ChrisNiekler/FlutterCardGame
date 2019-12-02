import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizard/logic/cardType.dart';
import 'package:wizard/ui/playing_card.dart';
import 'package:wizard/logic/card.dart' as logic;

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
  List<Widget> playersCards = [];
  List<PlayingCard> playCard = [];
  @override
  Widget build(BuildContext context) {
    playersCards = [
      showingCard(logic.Card(CardType.HEART, 0)),
      showingCard(logic.Card(CardType.HEART, 1)),
      showingCard(logic.Card(CardType.HEART, 2)),
      showingCard(logic.Card(CardType.HEART, 3)),
      showingCard(logic.Card(CardType.HEART, 4)),
      showingCard(logic.Card(CardType.HEART, 5)),
      showingCard(logic.Card(CardType.HEART, 6)),
      showingCard(logic.Card(CardType.HEART, 7)),
      showingCard(logic.Card(CardType.HEART, 8)),
      showingCard(logic.Card(CardType.HEART, 14)),
    ];
    playCard = [PlayingCard("8hearts")];
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
                              color: Colors.orange,
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
                                        color: Colors.yellow.shade600,
                                        child: Center(
                                          child: PlayingCard("3hearts"),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.orange.shade900,
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
                                        color: Colors.green.shade900,
                                        child: Center(
                                          child: PlayingCard("7hearts"),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.black,
                                        child: Center(
                                          child: PlayingCard("1hearts"),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.red.shade900,
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
                                        color: Colors.grey.shade700,
                                        child: Center(
                                          child: PlayingCard("14hearts"),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.teal.shade900,
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
                                color: Colors.teal,
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
              child: playersCardsView(playersCards),
            )
          ],
        ),
      ),
    );
  }

  Widget playersCardsView(List<Widget> playersCards) {
    return Container(
      color: Colors.red,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: playersCards,
            ),
          ),
          Expanded(
            child: Row(
              children: playersCards,
            ),
          ),
        ],
      ),
    );
  }
  Widget showingCard(logic.Card tcard) {
    return Expanded(
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          print(tcard.toString());
          setState(() {
            playersCards.remove(this);
          });
        },
        child: tcard.playerCardsWidget(),
      ),
    );
  }
}
