import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizard/experimental/gui/cardsOnTable.dart';
import 'package:wizard/logic/gamecard.dart' as logic;
import 'package:wizard/logic/wizard.dart';

/*
This class shows a dialog, in which the humanplayer can set his/her bet(s).
 */
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
              children: betWidgets(context),
            ),
          ),
        ],
      ),
    );
  }

  /*
  This method is an for loop which will run if the player has predicted
  her/his bet. So the ais are able to put their bet.
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

  List<Widget> betWidgets(BuildContext context) {
    List<Widget> listWidget = [];
    for (int i = 0; i <= 20; i++) {
      listWidget.add(new Container(
          child: RaisedButton(
        child: Text('$i'),
        onPressed: () {
          wizard.putInTheRightBetInList(0, i);
          Navigator.pop(context);
          _helperBet(i);
        },
      )));
    }
    return listWidget;
  }
}
