import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizard/0auth/services/database.dart';
import 'package:wizard/application/gui/enemyCardsWidgets.dart';
import 'package:wizard/application/gui/cardsOnTable.dart';
import 'package:wizard/logic/gamecard.dart';
import 'package:wizard/logic/wizard.dart';
import 'application/gui/usersViewWidget.dart';
import 'application/scoreboard.dart';
import 'application/gui/putBetDialog.dart';

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
  GamePage({this.amountPlayers, this.username, this.difficulty, this.userId});

  final int amountPlayers;
  final String username;
  final int difficulty;
  final userId;

  @override
  _GamePageState createState() => _GamePageState(userId, username);
}

class _GamePageState extends State<GamePage> {
  _GamePageState(this.userId, this.username);

  final String username;
  final userId;

  Wizard wizard;
  GameCard trumpCard;
  bool newRound = false;
  bool userPlayedCard = false;
  int size;
  int degreeOfDifficulty;

  List<GameCard> _emptyTable;

  @override
  void initState() {
    super.initState();
    size = widget.amountPlayers;
    degreeOfDifficulty = widget.difficulty;
    wizard = Wizard(playerAmount: size, difficulty: degreeOfDifficulty);
    trumpCard = wizard.takeTrumpCard();
    _emptyTable = new List(size);
    print('We have $size players');
    print('The difficulty is $degreeOfDifficulty');
    wizard.cardDistribution();
    wizard.determineLastPlayer();
    wizard.determineFirstPlayer();
    wizard.startGame();
    _putBetHelper();
  }

  List<Widget> displayedCards = [];

  @override
  Widget build(BuildContext context) {
    displayedCards = [];
    wizard.nextTrick();
    _buildUserCards();

    // the playground that is shown on the screen
    return SafeArea(
      child: Scaffold(
        // the appbar with the Button to show the Scoreboard
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
        // The body of the screen which contains the playground
        body: Container(
          color: Colors.green.shade700,
          child: Column(
            children: <Widget>[
              /*
              Depending of the size of the game, which is the amount of players
              who are playing, we build different Widgets.
              The one below determines if we show upside down cards on the top
              of the screen. Which is the  case for the size 4 and 6 players.
               */
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
                            // If we have 5 or more players, show gray cards
                            size >= 5
                                ? enemyCards(
                                    displayedCards.length, "gray", true)
                                : Container(),
                            // If we have 3 or more cards, show green cards
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
                                      // left cards on the table
                                      size >= 5
                                          /*
                                      Here we display the card that player
                                      three played, if we have five or more
                                      players.
                                       */
                                          ? cardOnTable(
                                              wizard.tableCards[three])
                                          : Container(),
                                      /*
                                      Played card of player two
                                      */
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
                                    /*
                                    This is the right side of the table.
                                    Depending on the size we create different
                                    widgets here
                                     */
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
  This widget shows either a button which will start a next round or a button
  for the end of the game to fill the score of the human player in the
  database.
   */
  Widget _nextRoundHelperWidget() {
    print('i am _nextRoundHelperWidget');
    return wizard.roundNumber == wizard.lastRound
        ? FlatButton(
            padding: EdgeInsets.all(8.0),
            child: Text('End of Game! Review Scoreboard'),
            onPressed: () {
              print("this is the end");
              if (wizard.roundNumber == wizard.lastRound) {
                wizard.roundNumber++;
                _saveScoreInDatabase();
              }
              _endOfGameShowDialog();
            },
          )
        : FlatButton(
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
              _putBetHelper();
            },
          );
  }

  /*
  This method opens the widget every round that the HumanPlayer
  is able to put her/his bet.
   */
  _putBetHelper() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => PutBetDialog(trumpCard, wizard),
      );
    });
  }

  /*
  This method will be needed if the game is dynamic an everyone can start
  the betting.
   */
//  helperBet() {
//    int bet;
//    wizard.betsNumber = 0;
//    int p = wizard.roundStarter;
//    int playerNumber = wizard.players.length;
//    for (int i = 0, n = wizard.players.length; i < n; i++) {
//      if (!wizard.players[p % n].ai) {
//        print('ich bin auch mal dran');
////        _putBetHelper();
//      } else {
////        while (!wizard.players[p % n].firstPlayer &&
////            wizard.getBetFromList((p - 1) % n, wizard.roundNumber) != null) {}
//        wizard.players[p % n].putBet(wizard.roundNumber, wizard.betsNumber,
//            trump: wizard.trumpType,
//            playerNumber: playerNumber,
//            firstPlayer: wizard.firstPlayer);
//        bet = wizard.players[p % n].bet;
//        wizard.betsNumber += bet;
//        wizard.putInTheRightBetInList(p % n, bet);
//      }
//      p++;
//    }
//  }

  /*
  This method builds the widget that depicts the cards of the
  user.
   */
  _buildUserCards() {
    wizard.players[0].handCards.forEach((element) {
      displayedCards.add(userCard(element));
    });
  }

  /*
  This method sets an integer in a int-arraylist for every instance of
   the class player.
   */
  void putInTheRightBetInList(
      int roundNumber, int playerByIndex, int betNumber) {
    wizard.players[playerByIndex].betsList[roundNumber] = betNumber;
  }

  /*
  This method checks if a instance of the class player has played all
  of his cards.
   */
  _noHandCardsAnyMore() {
    for (int i = 0; i < wizard.playerAmount; i++) {
      if (wizard.players[i].handCards.length > 0) return false;
    }
    return true;
  }

  /*
 This method is opening the Scoreboard.
  */
  _endOfGameShowDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scoreboard(wizard);
      },
    );
  }

  /*
  This method fills the score in the database at the end of the round. 
   */
  _saveScoreInDatabase() async {
    int userPoints = _giveRankingPoints();
    await DatabaseService(uid: userId).updateScoreDataAfterGame(userPoints);
  }

/*
  This method is giving the humanPlayer points in the ranking table
  if she/he has won.
  winner: 100 points
  second: 50 points
  third: 20 points
  else: 5 points
   */
  _giveRankingPoints() {
    List<int> pointsOfTheLastRound = [];
    int helper;
    int humanPoints = wizard.getPointsFromList(0, wizard.lastRound);

    for (int i = 0; i < wizard.playerAmount; i++) {
      pointsOfTheLastRound.add(wizard.getPointsFromList(i, wizard.lastRound));
    }

    for (int x = pointsOfTheLastRound.length; x > 1; --x) {
      for (int y = 0; y < x - 1; ++y) {
        if (pointsOfTheLastRound.elementAt(y) <
            pointsOfTheLastRound.elementAt(y + 1)) {
          helper = pointsOfTheLastRound.elementAt(y);
          pointsOfTheLastRound.insert(y, pointsOfTheLastRound.elementAt(y + 1));
          pointsOfTheLastRound.insert(y + 1, helper);
        }
      }
    }

    if (humanPoints == pointsOfTheLastRound.elementAt(0))
      humanPoints += 100;
    else if (humanPoints == pointsOfTheLastRound.elementAt(1))
      humanPoints += 50;
    else if (humanPoints == pointsOfTheLastRound.elementAt(2))
      humanPoints += 20;
    else
      humanPoints += 5;

    return humanPoints;
  }
}
