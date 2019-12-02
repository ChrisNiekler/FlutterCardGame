import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizard/experimental/backend/playersUI.dart';
import 'package:wizard/logic/artificial_intelligence/ai.dart';
import 'package:wizard/logic/artificial_intelligence/ki.dart';
import 'package:wizard/logic/artificial_intelligence/kuenstlicheIntelligenz.dart';
import 'package:wizard/logic/deck.dart';
import 'package:wizard/logic/player.dart';
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
  List<Player> players;
  Deck deck;
  @override
  void initState() {
    super.initState();
    players = createPlayers();
    deck = new Deck();
    cardDistribution();
  }

  List<Widget> displayedCards = [];
  logic.Card tableCard;
//  List<logic.Card> cList = [
//    logic.Card(CardType.HEART, 0),
//    logic.Card(CardType.HEART, 1),
//    logic.Card(CardType.HEART, 2),
//    logic.Card(CardType.HEART, 3),
//    logic.Card(CardType.HEART, 4),
//    logic.Card(CardType.HEART, 5),
//    logic.Card(CardType.HEART, 6),
//    logic.Card(CardType.HEART, 7),
//    logic.Card(CardType.HEART, 8),
//    logic.Card(CardType.HEART, 9),
//    logic.Card(CardType.HEART, 10),
//    logic.Card(CardType.HEART, 11),
//    logic.Card(CardType.HEART, 12),
//    logic.Card(CardType.HEART, 13),
//    logic.Card(CardType.HEART, 14),
//    logic.Card(CardType.CLUB, 0),
//    logic.Card(CardType.CLUB, 1),
//    logic.Card(CardType.CLUB, 2),
//    logic.Card(CardType.CLUB, 3),
//    logic.Card(CardType.CLUB, 4)
//  ];
  @override
  Widget build(BuildContext context) {
    displayedCards = [];
    players[0].handCards.forEach((element) {
      displayedCards.add(showingCard(element));
    });

    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
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
                                          child: (tableCard != null)
                                              ? playedCard((players[2] as Ai)
                                                  .handCards
                                                  .removeLast())
                                              : Container(),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.orange.shade900,
                                        child: Center(
                                            child: (tableCard != null)
                                                ? playedCard((players[1]
                                                        as KuenstlicheIntelligenz)
                                                    .handCards
                                                    .removeLast())
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
                                                ? playedCard((players[3] as Ki)
                                                    .handCards
                                                    .removeLast())
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
                                                ? playedCard((players[4]
                                                        as KuenstlicheIntelligenz)
                                                    .handCards
                                                    .removeLast())
                                                : Container()),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.teal.shade900,
                                        child: Center(
                                            child: (tableCard != null)
                                                ? playedCard((players[5] as Ai)
                                                    .handCards
                                                    .removeLast())
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

  Widget showingCard(logic.Card tcard) {
    return Expanded(
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          print(tcard.toString());
          setState(() {
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
    int roundNumber = 10;
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
}
