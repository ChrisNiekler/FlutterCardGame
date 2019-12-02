import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizard/experimental/backend/playersUI.dart';
import 'package:wizard/logic/cardType.dart';
import 'package:wizard/ui/playing_card.dart';
import 'package:wizard/logic/card.dart' as logic;
import 'backend/backendInit.dart';

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
  //static PlayersUI players;
  //Backend backend = new Backend(players.players);
  List<Widget> playersCards = [];
  List<PlayingCard> playCard = [];
  logic.Card tableCard;
  List<logic.Card> cList = [
    logic.Card(CardType.HEART, 0),
    logic.Card(CardType.HEART, 1),
    logic.Card(CardType.HEART, 2),
    logic.Card(CardType.HEART, 3),
    logic.Card(CardType.HEART, 4),
    logic.Card(CardType.HEART, 5),
    logic.Card(CardType.HEART, 6),
    logic.Card(CardType.HEART, 7),
    logic.Card(CardType.HEART, 8),
    logic.Card(CardType.HEART, 9),
    logic.Card(CardType.HEART, 10),
    logic.Card(CardType.HEART, 11),
    logic.Card(CardType.HEART, 12),
    logic.Card(CardType.HEART, 13),
    logic.Card(CardType.HEART, 14),
    logic.Card(CardType.CLUB, 0),
    logic.Card(CardType.CLUB, 1),
    logic.Card(CardType.CLUB, 2),
    logic.Card(CardType.CLUB, 3),
    logic.Card(CardType.CLUB, 4)
  ];
  @override
  Widget build(BuildContext context) {
    playersCards = [];
    cList.forEach((element) {
      playersCards.add(showingCard(element));
    });
//    hand.forEach(
//          (crd) {
//        crd.allowedToPlay = true;
//        n++;
//      },
//    );
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
                                          child: (tableCard != null)
                                              ? playedCard(tableCard)
                                              : Container(),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.orange.shade900,
                                        child: Center(
                                            child: (tableCard != null)
                                                ? playedCard(tableCard)
                                                : Container()),
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
                                            child: (tableCard != null)
                                                ? playedCard(tableCard)
                                                : Container()),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.black,
                                        child: Center(
                                            child: (tableCard != null)
                                                ? playedCard(tableCard)
                                                : Container()),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.red.shade900,
                                        child: Center(
                                          child: (tableCard != null)
                                              ? playedCard(tableCard)
                                              : Container(),
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
                                            child: (tableCard != null)
                                                ? playedCard(tableCard)
                                                : Container()),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.teal.shade900,
                                        child: Center(
                                            child: (tableCard != null)
                                                ? playedCard(tableCard)
                                                : Container()),
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
    List<Widget> listA = [];
    List<Widget> listB = [];
    if (playersCards.length > 10) {
      for (int i = 0; i < 10; i++) {
        listA.add(playersCards[i]);
      }
      for (int i = 10, j = playersCards.length; i < j; i++) {
        listB.add(playersCards[i]);
      }
    } else {
      listA = playersCards;
    }
    return Container(
      color: Colors.red,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: listA,
            ),
          ),
          playersCards.length > 10
              ? Expanded(
                  child: Row(
                    children: listB,
                  ),
                )
              : Container(),
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
            tableCard = tcard;
            cList.remove(tcard);
          });
        },
        child: tcard.playerCardsWidget(),
      ),
    );
  }

  Widget playedCard(logic.Card tCard) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: tCard.playerCardsWidget(),
    );
  }
}
