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
import 'experimental/showingCardWidget.dart';
import 'experimental/gui/usersViewWidget.dart';
import 'experimental/scoreboard.dart';
import 'experimental/gui/putBetDialog.dart';

class GamePage extends StatefulWidget {
  GamePage({this.amountPlayers, this.username});

  final int amountPlayers;
  final String username;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<Player> players;
  List<logic.Card> playedCards;
  Deck deck;
  logic.Card trumpCard;
  int roundNumber = 1;
  int maxRound;
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
    players = createPlayers(widget.amountPlayers);
    deck = new Deck();
    cardDistribution();
    trumpCard = deck.takeCard();
    _putBetHelper();
    print('We have ${players.length} players');
    maxRound = (60 / widget.amountPlayers).round().toInt();
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
      if (widget.amountPlayers == 3) {
        playerTwoField =
            (players[1] as KuenstlicheIntelligenz).handCards.removeLast();
        playerFiveField = (players[2] as Ai).handCards.removeLast();
      } else if (widget.amountPlayers == 4) {
        playerTwoField =
            (players[1] as KuenstlicheIntelligenz).handCards.removeLast();
        playerFiveField = (players[2] as Ai).handCards.removeLast();
        playerFourField = (players[3] as Ki).handCards.removeLast();
      } else if (widget.amountPlayers == 5) {
        playerTwoField =
            (players[1] as KuenstlicheIntelligenz).handCards.removeLast();
        playerFiveField = (players[2] as Ai).handCards.removeLast();
        playerFourField = (players[3] as Ki).handCards.removeLast();
        playerThreeField =
            (players[4] as KuenstlicheIntelligenz).handCards.removeLast();
      } else {
        playerTwoField =
            (players[1] as KuenstlicheIntelligenz).handCards.removeLast();
        playerThreeField = (players[2] as Ai).handCards.removeLast();
        playerFourField = (players[3] as Ki).handCards.removeLast();
        playerFiveField =
            (players[4] as KuenstlicheIntelligenz).handCards.removeLast();
        playerSixField = (players[5] as Ai).handCards.removeLast();
      }
      userPlayedCard = false;
    }
    if (newRound) {
      setState(() {
        print("Round number: $roundNumber");
        print("Deck size: ${deck.size()}");
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.green.shade700,
            elevation: 0.0,
            actions: <Widget>[
              FlatButton(
                child: Text("Scoreboard"),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return scoretable(context);
                    },
                  );
                },
              )
            ],
          ),
        ),
        body: Container(
          color: Colors.green.shade700,
          child: Column(
            children: <Widget>[
              widget.amountPlayers > 3
                  ? Expanded(
                      flex: 10,
                      child: enemyCards(displayedCards.length, "red", false))
                  : Container(),
              Expanded(
                flex: 60,
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 10,
                        child: Column(
                          children: <Widget>[
                            widget.amountPlayers >= 5
                                ? enemyCards(
                                    displayedCards.length, "gray", true)
                                : Container(),
                            widget.amountPlayers >= 3
                                ? enemyCards(
                                    displayedCards.length, "green", true)
                                : Container(),
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
                                      widget.amountPlayers >= 5
                                          ? cardOnTable(playerThreeField)
                                          : Container(),
                                      widget.amountPlayers >= 3
                                          ? cardOnTable(playerTwoField)
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                              // cards on table second column
                              Expanded(
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      widget.amountPlayers > 3
                                          ? cardOnTable(playerFourField)
                                          : Container(),
                                      cardOnTable(trumpCard, trumpCard: true),
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
                                      widget.amountPlayers >= 3
                                          ? cardOnTable(playerFiveField)
                                          : Container(),
                                      widget.amountPlayers > 5
                                          ? cardOnTable(playerSixField)
                                          : Container(),
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
                              widget.amountPlayers >= 3
                                  ? enemyCards(
                                      displayedCards.length, "blue", true)
                                  : Container(),
                              widget.amountPlayers > 5
                                  ? enemyCards(
                                      displayedCards.length, "purple", true)
                                  : Container(),
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
            if (players[players.length - 1].handCards.length == 1 &&
                roundNumber < maxRound) {
              print("Next round will be initialized");
              newRound = true;
              roundNumber++;
              deck = new Deck();
              cardDistribution();
              pickTrump();
              _putBetHelper();
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

  void pickTrump() {
    if (deck.size() != 0) {
      trumpCard = deck.takeCard();
    } else {
      trumpCard = null;
    }
  }

  _putBetHelper() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => putBet(context),
      );
    });
  }
}
