import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizard/experimental/gui/enemyCardsWidgets.dart';
import 'package:wizard/experimental/gui/cardsOnTable.dart';
import 'package:wizard/logic/gamecard.dart';
import 'package:wizard/logic/wizard.dart';
import 'experimental/gui/usersViewWidget.dart';
import 'experimental/scoreboard.dart';
import 'experimental/gui/putBetDialog.dart';

// some constants to make the code easier to read
const user = 0;
const two = 1;
const three = 2;
const four = 3;
const five = 4;
const six = 5;

/*
  This is the GamePage, the screen where the game will take place.
 */
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

  List<GameCard> _emptyTable;

  @override
  void initState() {
    super.initState();
    size = widget.amountPlayers;
    wizard = Wizard(playerAmount: size);
    trumpCard = wizard.takeTrumpCard();
    //tableCards = new List(size);
    //_emptyTable = tableCards;
    _emptyTable = new List(size);
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
                                          ? cardOnTable(
                                              wizard.tableCards[three])
                                          : Container(),

                                      cardOnTable(wizard.tableCards[two]),
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
                                          ? cardOnTable(wizard.tableCards[four])
                                          : Container(),
                                      size == 4
                                          ? cardOnTable(wizard.tableCards[two])
                                          : Container(),
                                      cardOnTable(trumpCard, trumpCard: true),
                                      cardOnTable(wizard.tableCards[user]),
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
                                          ? cardOnTable(
                                              wizard.tableCards[three])
                                          : Container(),
                                      size == 4 || size == 5
                                          ? cardOnTable(wizard.tableCards[four])
                                          : Container(),
                                      size >= 5
                                          ? cardOnTable(wizard.tableCards[five])
                                          : Container(),
                                      size == 6
                                          ? cardOnTable(wizard.tableCards[six])
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

  /*
  This Widget displays one of the cards of the user.
  It is supposed to be stacked in a list to display the whole list,
  which equals the hand cards of the user
   */
  Widget userCard(GameCard tCard) {
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
            //TODO everything in here has to go into the wizard class
            wizard.userPlayCard(chosenCard: tCard);
            wizard.playersPlay();
            // returns card from backend
            wizard.tableCards = new List(size);
            wizard.tableCards = wizard.playedCards;
            //TODO this has to be somewhere else
            _buildUserCards();
            /*
            //FIXME create an userCard parameter in wizard.dart
                This button should just update this parameter
                The parameter should be null until a card is choosen
                and use some kind of listener.
             */
            wizard.usersChoosenCard = tCard;
          });
        },
        child: tCard.playerCardsWidget(),
      ),
    );
  }

  /*
  TODO add some description
   */
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
          wizard.tableCards = new List(size);
          trumpCard = wizard.takeTrumpCard();
        });
        _helperBet();
      },
    );
  }

  /*
  TODO add some description
   */
  Widget playedCard(GameCard tCard) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: tCard.playerCardsWidget(),
    );
  }

  /*
  TODO add some description
   */
  _putBetHelper() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => PutBetDialog(trumpCard, wizard),
//            putBet(context, trumpCard, wizard.roundNumber),
      );
      wizard.betsNumber += wizard.getBetFromList(0, wizard.roundNumber);
    });
  }

  /*
  TODO add some description
   */
  _helperBet() {
    int bet;
    wizard.betsNumber = 0;
    int p = wizard.roundStarter;
    int playerNumber = wizard.players.length;
    for (int i = 0, n = wizard.players.length; i < n; i++) {
      if (!wizard.players[p % n].ai) {
        print('ich bin auch mal dran');
        _putBetHelper();
      } else {
//        while (!wizard.players[p % n].firstPlayer &&
//            wizard.getBetFromList((p - 1) % n, wizard.roundNumber) != null) {}
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

  /*
  TODO add some description
   */
  _buildUserCards() {
    wizard.players[0].handCards.forEach((element) {
      displayedCards.add(userCard(element));
    });
  }

  /*
  TODO add some description
   */
  void putInTheRightBetInList(
      int roundNumber, int playerByIndex, int betNumber) {
    wizard.players[playerByIndex].betsList[roundNumber] = betNumber;
  }

  /*
  TODO add some description
   */
  _noHandCardsAnyMore() {
    for (int i = 0; i < wizard.playerAmount; i++) {
      if (wizard.players[i].handCards.length > 0) return false;
    }
    return true;
  }
}
