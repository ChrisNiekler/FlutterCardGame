import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizard/experimental/backend/playersUI.dart';
import 'package:wizard/logic/artificial_intelligence/ai.dart';
import 'package:wizard/logic/artificial_intelligence/ki.dart';
import 'package:wizard/logic/artificial_intelligence/kuenstlicheIntelligenz.dart';
import 'package:wizard/logic/deck.dart';
import 'package:wizard/logic/player.dart';
import 'package:wizard/logic/card.dart' as logic;
import 'showingCardWidget.dart';

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
  List<Player> players;
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
        print(roundNumber);
        print(deck.size());
      });
    }

    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: scoreboard(),
            ),
            Expanded(
              flex: 10,
              child: Container(
                color: Colors.green,
                child: upsideDownCardsTop(displayedCards.length, "red"),
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
                              child: upsideDownCardsSides(
                                  displayedCards.length, "gray"),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.orange,
                              child: upsideDownCardsSides(
                                  displayedCards.length, "green"),
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
                                          child: (playerThreeField != null)
                                              ? playedCard(playerThreeField)
                                              : Container(),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.orange.shade900,
                                        child: Center(
                                            child: (playerTwoField != null)
                                                ? playedCard(playerTwoField)
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
                                            child: (playerFourField != null)
                                                ? playedCard(playerFourField)
                                                : Container()),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.black,
                                        child: Center(
                                            child: (trumpCard != null)
                                                ? playedCard(trumpCard)
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
                                            child: (playerFiveField != null)
                                                ? playedCard(playerFiveField)
                                                : Container()),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.teal.shade900,
                                        child: Center(
                                            child: (playerSixField != null)
                                                ? playedCard(playerSixField)
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
                                child: upsideDownCardsSides(
                                    displayedCards.length, "blue"),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.teal,
                                child: upsideDownCardsSides(
                                    displayedCards.length, "purple"),
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
              child: playersCardsView(displayedCards),
            )
          ],
        ),
      ),
    );
  }

  Widget playersCardsView(List<Widget> tempCards) {
    List<Widget> listA = [];
    List<Widget> listB = [];
    int k = 0;
    if (tempCards.length > 10) {
      for (; k < tempCards.length / 2; k++) {
        listA.add(tempCards[k]);
      }
      for (int j = tempCards.length; k < j; k++) {
        listB.add(tempCards[k]);
      }
    } else {
      listA = tempCards;
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
          tempCards.length > 10
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

  Widget upsideDownCardsSides(int amountOfCards, String color) {
    List<Widget> cardListA = [];
    List<Widget> cardListB = [];
    for (int i = 0; i < amountOfCards; i++) {
      if (i < amountOfCards / 2 || amountOfCards < 11) {
        cardListA.add(
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: RotatedBox(
                  quarterTurns: 5,
                  child: Image.asset("images/cards/${color}_back.png"),
                ),
              ),
            ),
          ),
        );
      } else {
        cardListB.add(
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: RotatedBox(
                  quarterTurns: 5,
                  child: Image.asset("images/cards/${color}_back.png"),
                ),
              ),
            ),
          ),
        );
      }
    }
    return Row(
      children: <Widget>[
        Expanded(child: Column(children: cardListA)),
        amountOfCards > 10
            ? Expanded(child: Column(children: cardListB))
            : Container()
      ],
    );
  }

  Widget upsideDownCardsTop(int amountOfCards, String color) {
    List<Widget> cardListA = [];
    List<Widget> cardListB = [];
    for (int i = 0; i < amountOfCards; i++) {
      if (i < amountOfCards / 2 || amountOfCards < 11) {
        cardListA.add(
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Image.asset("images/cards/${color}_back.png"),
              ),
            ),
          ),
        );
      } else {
        cardListB.add(
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Image.asset("images/cards/${color}_back.png"),
              ),
            ),
          ),
        );
      }
    }
    return Column(
      children: <Widget>[
        Expanded(child: Row(children: cardListA)),
        amountOfCards > 10
            ? Expanded(child: Row(children: cardListB))
            : Container()
      ],
    );
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
