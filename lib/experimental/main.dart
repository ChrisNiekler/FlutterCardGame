import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizard/experimental/gui/enemyCardsWidgets.dart';
import 'package:wizard/experimental/gui/cardsOnTable.dart';
import 'package:wizard/experimental/backend/playersUI.dart';
import 'package:wizard/logic/artificial_intelligence/ai.dart';
import 'package:wizard/logic/artificial_intelligence/ki.dart';
import 'package:wizard/logic/artificial_intelligence/kuenstlicheIntelligenz.dart';
import 'package:wizard/logic/deck.dart';
import 'package:wizard/logic/player.dart';
import 'package:wizard/logic/card.dart' as logic;
import 'showingCardWidget.dart';
import 'gui/usersViewWidget.dart';

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
        home: GamePage());
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<Player> players;
  List<logic.Card> playedCards;
  Deck deck;
  logic.Card trumpCard;
  int roundNumber = 1;
  int maxRound = 10;
  bool newRound = false;
  bool userPlayedCard = false;
  logic.Card playerOneField;
  logic.Card playerTwoField;
  logic.Card playerThreeField;
  logic.Card playerFourField;
  logic.Card playerFiveField;
  logic.Card playerSixField;
  @override
  void initState() {
    super.initState();
    players = createPlayers();
    deck = new Deck();
    cardDistribution();
    trumpCard = deck.takeCard();
  }

  List<Widget> displayedCards = [];
  logic.Card tableCard;

  @override
  Widget build(BuildContext context) {
    displayedCards = [];
    players[0].handCards.forEach((element) {
      displayedCards.add(showingCardOld(element));
    });
    if (userPlayedCard) {
      playerTwoField =
          (players[1] as KuenstlicheIntelligenz).handCards.removeLast();
      playerThreeField = (players[2] as Ai).handCards.removeLast();
      playerFourField = (players[3] as Ki).handCards.removeLast();
      playerFiveField =
          (players[4] as KuenstlicheIntelligenz).handCards.removeLast();
      playerSixField = (players[5] as Ai).handCards.removeLast();
      userPlayedCard = false;
    }
    if (newRound) {
      setState(() {
        print("Round number: $roundNumber");
        print("Deck size: ${deck.size()}");
      });
    }

    return SafeArea(
      child: Container(
        color: Colors.green.shade700,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: scoreboard(),
            ),
            Expanded(
                flex: 10,
                child: enemyCards(displayedCards.length, "red", false)),
            Expanded(
              flex: 60,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: Column(
                        children: <Widget>[
                          enemyCards(displayedCards.length, "gray", true),
                          enemyCards(displayedCards.length, "green", true),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 30,
                      child: Container(
                        // cards on the table first column
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    cardOnTable(playerThreeField),
                                    cardOnTable(playerTwoField),
                                  ],
                                ),
                              ),
                            ),
                            // cards on table second column
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    cardOnTable(playerFourField),
                                    Container(
                                      child: cardOnTable(trumpCard),
                                    ),
                                    cardOnTable(tableCard),
                                  ],
                                ),
                              ),
                            ),
                            // cards on table third column
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    cardOnTable(playerFiveField),
                                    cardOnTable(playerSixField),
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
                        child: Column(
                          children: <Widget>[
                            enemyCards(displayedCards.length, "blue", true),
                            enemyCards(displayedCards.length, "purple", true),
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
              child: playersCardsView(displayedCards),
            )
          ],
        ),
      ),
    );
  }

  Widget showingCardOld(logic.Card tcard) {
    return Expanded(
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          print(tcard.toString());
          setState(() {
            // FIX: condition
            if (players[5].handCards.length == 1 && roundNumber < maxRound) {
              print("Next round will be initialized");
              newRound = true;
              roundNumber++;
              deck = new Deck();
              cardDistribution();
              if (deck.size() != 0) {
                trumpCard = deck.takeCard();
              } else {
                trumpCard = null;
              }
            } else {
              newRound = false;
            }
            userPlayedCard = true;
            tableCard = tcard;
            players[0].handCards.remove(tcard);
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

  void cardDistribution() {
    int lng = players.length;
    for (int i = 0; i < roundNumber; i++) {
      for (int j = 0; j < lng; j++) {
        players[j].handCards.add(deck.takeCard());
      }
    }
  }

  Widget scoreboard() {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          new RaisedButton(
              child: new Text('Scoreboard',
                  style: new TextStyle(fontSize: 17.0, color: Colors.grey)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => scoretable()),
                );
              })
        ],
      ),
    );
  }

  Widget scoretable() {
    return AlertDialog(
      content: Column(
        children: <Widget>[
          Container(
            child: Text("hallo"),
          ),
        ],
      ),
    );
  }
}
