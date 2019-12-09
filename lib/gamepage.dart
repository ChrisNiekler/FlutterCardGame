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
import 'package:wizard/logic/wizard.dart';
import 'experimental/showingCardWidget.dart';
import 'experimental/gui/usersViewWidget.dart';
import 'experimental/scoreboard.dart';
import 'experimental/gui/putBetDialog.dart';

const user = 0;
const two = 1;
const three = 2;
const four = 3;
const five = 4;
const six = 5;

class GamePage extends StatefulWidget {
  GamePage({this.amountPlayers, this.username});

  final int amountPlayers;
  final String username;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Wizard wizard;
  logic.Card trumpCard;
  bool newRound = false;
  bool userPlayedCard = false;
  int size;
//  logic.Card usersCardField;
//  logic.Card playerTwoField;
//  logic.Card playerThreeField;
//  logic.Card playerFourField;
//  logic.Card playerFiveField;
//  logic.Card playerSixField;
  List<logic.Card> tableCards = [];

  @override
  void initState() {
    super.initState();
    size = widget.amountPlayers;
    wizard = Wizard(playerAmount: widget.amountPlayers);
    trumpCard = wizard.takeTrumpCard();
    tableCards = new List(widget.amountPlayers);
    _putBetHelper();
    print('We have ${widget.amountPlayers} players');
    wizard.cardDistribution();
  }

  List<Widget> displayedCards = [];

  @override
  Widget build(BuildContext context) {
    displayedCards = [];
    wizard.nextTrick();
    _buildUserCards();

//    if (userPlayedCard) {
//      if (widget.amountPlayers == 3) {
//        playerTwoField =
//            (players[1] as KuenstlicheIntelligenz).handCards.removeLast();
//        playerFiveField = (players[2] as Ai).handCards.removeLast();
//      } else if (widget.amountPlayers == 4) {
//        playerTwoField =
//            (players[1] as KuenstlicheIntelligenz).handCards.removeLast();
//        playerFiveField = (players[2] as Ai).handCards.removeLast();
//        playerFourField = (players[3] as Ki).handCards.removeLast();
//      } else if (widget.amountPlayers == 5) {
//        playerTwoField =
//            (players[1] as KuenstlicheIntelligenz).handCards.removeLast();
//        playerFiveField = (players[2] as Ai).handCards.removeLast();
//        playerFourField = (players[3] as Ki).handCards.removeLast();
//        playerThreeField =
//            (players[4] as KuenstlicheIntelligenz).handCards.removeLast();
//      } else {
//        playerTwoField =
//            (players[1] as KuenstlicheIntelligenz).handCards.removeLast();
//        playerThreeField = (players[2] as Ai).handCards.removeLast();
//        playerFourField = (players[3] as Ki).handCards.removeLast();
//        playerFiveField =
//            (players[4] as KuenstlicheIntelligenz).handCards.removeLast();
//        playerSixField = (players[5] as Ai).handCards.removeLast();
//      }
//      userPlayedCard = false;
//    }
//    if (newRound) {
//      setState(() {
//        print("Round number: $roundNumber");
//        print("Deck size: ${deck.size()}");
//      });
//    }

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
              size == 4 || size == 6
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
                                      // left cards on table
                                      size >= 5
                                          ? cardOnTable(tableCards[three])
                                          : Container(),

                                      cardOnTable(tableCards[two]),
                                    ],
                                  ),
                                ),
                              ),
                              // cards on table second column
                              Expanded(
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      size == 6
                                          ? cardOnTable(tableCards[four])
                                          : Container(),
                                      size == 4
                                          ? cardOnTable(tableCards[two])
                                          : Container(),
                                      cardOnTable(trumpCard, trumpCard: true),
                                      cardOnTable(tableCards[user]),
                                    ],
                                  ),
                                ),
                              ),
                              // cards on table third column
                              Expanded(
                                child: Container(
                                  child: Column(
                                    // right side of table cards
                                    children: <Widget>[
                                      size == 3
                                          ? cardOnTable(tableCards[three])
                                          : Container(),
                                      size == 4 || size == 5
                                          ? cardOnTable(tableCards[four])
                                          : Container(),
                                      size >= 5
                                          ? cardOnTable(tableCards[five])
                                          : Container(),
                                      size == 6
                                          ? cardOnTable(tableCards[six])
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
                              widget.amountPlayers >= 5
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

  Widget showingCardOld(logic.Card tCard) {
    return Expanded(
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          print(tCard.toString());
          if (wizard.checkEndOfRound()) {
            print('Test');
            print("Next round will be initialized");
            newRound = true;
            wizard.nextRound();
            trumpCard = wizard.takeTrumpCard();
            _putBetHelper();
          } else {
            newRound = false;
          }

          setState(() {
            wizard.userPlayCard(choosenCard: tCard);
            wizard.playersPlay();
            // returns card from backend
            tableCards = new List(widget.amountPlayers);
            tableCards = wizard.playedCards;
            _buildUserCards();
          });
        },
        child: tCard.playerCardsWidget(),
      ),
    );
  }

  Widget playedCard(logic.Card tCard) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: tCard.playerCardsWidget(),
    );
  }

  _putBetHelper() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => putBet(context),
      );
    });
  }

  _buildUserCards() {
    wizard.players[0].handCards.forEach((element) {
      displayedCards.add(showingCardOld(element));
    });
  }
}
