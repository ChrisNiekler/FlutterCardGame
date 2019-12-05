import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizard/logic/player.dart';

//Todo maybe this class is helpful
//class PutBetDialog extends StatefulWidget {
//  PutBetDialog({this.players, this.roundNumber, this.betsNumber});
//
//  List<Player> players;
//  int roundNumber;
//  int betsNumber;
//
//  @override
//  _PutBetDialogState createState() => _PutBetDialogState();
//}
//
//class _PutBetDialogState extends State<PutBetDialog> {
//  int betNumber;
//  bool userPutBet = false;
//
//  void putBet() {
//    for (int i = 1; i < widget.players.length; i++) {
//      widget.players[i].putBet(widget.roundNumber, widget.betsNumber);
//    }
//  }
//
//  @override
//  AlertDialog build(BuildContext context) {
//    return AlertDialog(
//      title: Text("Put your bet for this round"),
//      content: TextField(
//        decoration: InputDecoration(
//          border: InputBorder.none,
//          hintText: 'Enter the number of bets for this round',
//        ),
//        onChanged: (bet) {
//          print(bet);
//        },
//      ),
//      actions: <Widget>[
//        RaisedButton(
//            child: Text(
//              "OK",
//              style: TextStyle(color: Colors.white),
//            ),
//            onPressed: () {
//              Navigator.pop(context);
//            })
//      ],
//    );
//  }
//}

//TODO find a solution for giving the Data to the scoreboard
Widget putBet(BuildContext context) {
  int bet;
  bool userPutBet = false;
  if (!userPutBet) {
    return new Column(
      children: <Widget>[
        AlertDialog(
          title: Text("Put your bet for this round"),
          content: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter the number of bets for this round',
            ),
            onChanged: (bet) {
              print(bet);
            },
          ),
          actions: <Widget>[
            RaisedButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ],
    );
  }
//  else if (userPutBet) {
//    playerTwoField =
//        (players[1] as KuenstlicheIntelligenz).handCards.removeLast();
//    playerThreeField = (players[2] as Ai).handCards.removeLast();
//    playerFourField = (players[3] as Ki).handCards.removeLast();
//    playerFiveField =
//        (players[4] as KuenstlicheIntelligenz).handCards.removeLast();
//    playerSixField = (players[5] as Ai).handCards.removeLast();
//    userPutBet = false;
//  }
  userPutBet = true;
}
