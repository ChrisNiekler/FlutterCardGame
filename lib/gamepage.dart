import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizard/experimental/gui/enemyCardsWidgets.dart';
import 'package:wizard/experimental/gui/cardsOnTable.dart';
import 'package:wizard/logic/gamecard.dart';
import 'package:wizard/logic/wizard.dart';
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
  GameCard trumpCard;
  bool newRound = false;
  bool userPlayedCard = false;
  int size;

  List<GameCard> tableCards = [];
  List<GameCard> _emptyTable;

  @override
  void initState() {
    super.initState();
    size = widget.amountPlayers;
    wizard = Wizard(playerAmount: size);
    trumpCard = wizard.takeTrumpCard();
    tableCards = new List(size);
    _emptyTable = tableCards;
    print('We have $size players');
    wizard.cardDistribution();
    wizard.determineLastPlayer();
    wizard.determineFirstPlayer();
    wizard.startGame();
    _helperBet();
  }

  List<Widget> displayedCards = [];

  @override
  Widget build(BuildContext context) {
    displayedCards = [];
    wizard.nextTrick();
    _buildUserCards();

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
                      return Scoreboard(wizard);
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
                            size >= 5
                                ? enemyCards(
                                    displayedCards.length, "gray", true)
                                : Container(),
                            size >= 3
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
                              size >= 3
                                  ? enemyCards(
                                      displayedCards.length, "blue", true)
                                  : Container(),
                              size >= 5
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
                child: _noHandCardsAnyMore()
                    ? _nextRoundHelperWidget()
                    : playersCardsView(displayedCards),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showingCardOld(GameCard tCard) {
    return Expanded(
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          print(tCard.toString());
//          if (wizard.checkEndOfRound()) {
////            print("Next round will be initialized");
////            newRound = true;
//////            wizard.nextRound();
//////            setState(() {
//////              tableCards = new List(size);
//////              trumpCard = wizard.takeTrumpCard();
//////            });
//////
//////            _putBetHelper();
////          } else {
////            newRound = false;
////          }

          setState(() {
            wizard.userPlayCard(chosenCard: tCard);
            wizard.playersPlay();
            // returns card from backend
            tableCards = new List(size);
            tableCards = wizard.playedCards;
            _buildUserCards();
          });
        },
        child: tCard.playerCardsWidget(),
      ),
    );
  }

  Widget _nextRoundHelperWidget() {
    print('ich hiab funktiriondret');
    return FlatButton(
      padding: EdgeInsets.all(8.0),
      child: Text('Start next Round!'),
      onPressed: () {
        print("Next round will be initialized");
        newRound = true;
        wizard.nextRound();
        setState(() {
          tableCards = new List(size);
          trumpCard = wizard.takeTrumpCard();
        });
        _helperBet();
      },
    );
  }

  Widget playedCard(GameCard tCard) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: tCard.playerCardsWidget(),
    );
  }

  _putBetHelper() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            PutBetDialog(trumpCard, wizard),
//            putBet(context, trumpCard, wizard.roundNumber),
      );
      wizard.betsNumber += wizard.getBetFromList(0, wizard.roundNumber);
    });
  }

  _helperBet() {
    int bet;
    wizard.betsNumber = 0;
    int p = wizard.roundStarter;
    int playerNumber = wizard.players.length;
    for (int i = 0, n = wizard.players.length; i < n; i++) {
      if (!wizard.players[p % n].ai) {
        _putBetHelper();
      } else {
        wizard.players[p % n].putBet(wizard.roundNumber, wizard.betsNumber,
            trump: wizard.trumpType,
            playerNumber: playerNumber,
            firstPlayer: wizard.firstPlayer);
        bet = wizard.players[p % n].bet;
        wizard.betsNumber += bet;
        wizard.putInTheRightBetInList(p % n, bet);
      }
      p++;
    }
  }

//  _helperPlay() {
//    int p = wizard.trickStarter;
//    int playerNumber = wizard.players.length;
//    for (int i = 0, n = playerNumber; i < n; i++) {
//      if (!wizard.players[p % n].ai) {
////        todo what to show if human
//      } else {
////        todo what to do if ai
//      }
//      p++;
//    }
//  }

  _buildUserCards() {
    wizard.players[0].handCards.forEach((element) {
      displayedCards.add(showingCardOld(element));
    });
  }

  void putInTheRightBetInList(
      int roundNumber, int playerByIndex, int betNumber) {
    wizard.players[playerByIndex].betsList[roundNumber] = betNumber;
  }

  _noHandCardsAnyMore() {
    for (int i = 0; i < wizard.playerAmount; i++){
      if(wizard.players[i].handCards.length > 0) return false;
    }
    return true;
  }
}
