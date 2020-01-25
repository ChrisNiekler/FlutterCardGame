import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizard/experimental/gui/cardsOnTable.dart';
import 'package:wizard/logic/gamecard.dart' as logic;
import 'package:wizard/logic/wizard.dart';

class PutBetDialog extends StatelessWidget {
  PutBetDialog(this.trumpCard, this.wizard);

  logic.GameCard trumpCard;
  Wizard wizard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100.0),
      child: SimpleDialog(
        titlePadding: const EdgeInsets.all(10.0),
        contentPadding: const EdgeInsets.fromLTRB(35, 35, 35, 35),
        title: Row(
          children: <Widget>[
            //TODO fix betsNumber (humanplayer starts betting and sometimes there are already bets)
            Text(
                "Put your bet for this round.\nCurrent: ${wizard.betsNumber} bet(s)"),
            Container(child: cardOnTable(trumpCard, trumpCard: true)),
          ],
        ),
        children: <Widget>[
          Container(
            width: 700,
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  child: RaisedButton(
                    child: Text('0'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 0);
                      Navigator.pop(context);
                      _helperBet(0);
                      //hier hat player 0 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('1'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 1);
                      Navigator.pop(context);
                      _helperBet(1);
                      //hier hat player 1 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('2'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 2);
                      Navigator.pop(context);
                      _helperBet(2);
                      //hier hat player 2 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('3'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 3);
                      Navigator.pop(context);
                      _helperBet(3);
                      //hier hat player 3 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('4'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 4);
                      Navigator.pop(context);
                      _helperBet(4);
                      //hier hat player 4 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('5'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 5);
                      Navigator.pop(context);
                      _helperBet(5);
                      //hier hat player 5 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('6'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 6);
                      Navigator.pop(context);
                      _helperBet(6);
                      //hier hat player 6 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('7'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 7);
                      Navigator.pop(context);
                      _helperBet(7);
                      //hier hat player 7 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('8'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 8);
                      Navigator.pop(context);
                      _helperBet(8);
                      //hier hat player 8 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('9'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 9);
                      Navigator.pop(context);
                      _helperBet(9);
                      //hier hat player 9 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('10'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 10);
                      Navigator.pop(context);
                      _helperBet(10);
                      //hier hat player 10 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('11'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 11);
                      Navigator.pop(context);
                      _helperBet(11);
                      //hier hat player 11 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('12'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 12);
                      Navigator.pop(context);
                      _helperBet(12);
                      //hier hat player 12 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('13'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 13);
                      Navigator.pop(context);
                      _helperBet(13);
                      //hier hat player 13 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('14'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 14);
                      Navigator.pop(context);
                      _helperBet(14);
                      //hier hat player 14 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('15'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 15);
                      Navigator.pop(context);
                      _helperBet(15);
                      //hier hat player 15 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('16'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 16);
                      Navigator.pop(context);
                      _helperBet(16);
                      //hier hat player 16 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('17'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 17);
                      Navigator.pop(context);
                      _helperBet(17);
                      //hier hat player 17 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('18'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 18);
                      Navigator.pop(context);
                      _helperBet(18);
                      //hier hat player 18 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('19'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 19);
                      Navigator.pop(context);
                      _helperBet(19);
                      //hier hat player 19 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('20'),
                    onPressed: () {
                      wizard.putInTheRightBetInList(0, 20);
                      Navigator.pop(context);
                      _helperBet(20);
                      //hier hat player 20 gewettet
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*
  TODO review this description
  This methode is an for loop which will run
   if the player has predicted her/his bet.
   */
  _helperBet(int userBet) {
    int bet;
    wizard.betsNumber = userBet;
    int playerNumber = wizard.players.length;
    for (int i = 1, n = playerNumber; i < n; i++) {
      wizard.players[i].putBet(wizard.roundNumber, wizard.betsNumber,
          trump: wizard.trumpType,
          playerNumber: playerNumber,
          firstPlayer: wizard.firstPlayer);
      bet = wizard.players[i].bet;
      wizard.betsNumber += bet;
      wizard.putInTheRightBetInList(i, bet);
    }
  }
}
