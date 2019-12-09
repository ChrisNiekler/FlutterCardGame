import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wizard/logic/player.dart';
import 'package:wizard/gamepage.dart';
import 'package:wizard/experimental/gui/cardsOnTable.dart';
import 'package:wizard/logic/card.dart' as logic;

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
//try showDialog for barrierDismissible: false and giving back the result
//try a list of which is scrollable (table) to give the user a suggestion which int num he/she should bet
//Widget putBet(BuildContext context) {
//  int bet;
//  bool userPutBet = false;
//  if (!userPutBet) {
//    return AlertDialog(
//          title: Text("Put your bet for this round"),
//          content: TextField(
//            decoration: InputDecoration(
//              border: InputBorder.none,
//              hintText: 'Enter the number of bets for this round',
//            ),
//            onChanged: (bet) {
//              print(bet);
//            },
//          ),
//          actions: <Widget>[
//            RaisedButton(
//                child: Text(
//                  "OK",
//                  style: TextStyle(color: Colors.white),
//                ),
//                onPressed: () {
//                  Navigator.pop(context);
//                })
//          ],
//        );
//  }
////  else if (userPutBet) {
////    playerTwoField =
////        (players[1] as KuenstlicheIntelligenz).handCards.removeLast();
////    playerThreeField = (players[2] as Ai).handCards.removeLast();
////    playerFourField = (players[3] as Ki).handCards.removeLast();
////    playerFiveField =
////        (players[4] as KuenstlicheIntelligenz).handCards.removeLast();
////    playerSixField = (players[5] as Ai).handCards.removeLast();
////    userPutBet = false;
////  }
//  userPutBet = true;
//}

Widget putBet(BuildContext context, logic.Card trumpCard) {
  int bet;
  bool userPutBet = false;
  if (!userPutBet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100.0),
      child: SimpleDialog(
        titlePadding: const EdgeInsets.all(10.0),
        contentPadding: const EdgeInsets.fromLTRB(35, 35, 35, 35),
        title: Row(
          children: <Widget>[
            Text("Put your bet for this round"),
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
                      Navigator.pop(context);
                      //hier hat player 0 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('1'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 1 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('2'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 2 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('3'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 3 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('4'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 4 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('5'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 5 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('6'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 6 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('7'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 7 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('8'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 8 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('9'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 9 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('10'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 10 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('11'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 11 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('12'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 12 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('13'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 13 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('14'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 14 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('15'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 15 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('16'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 16 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('17'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 17 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('18'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 18 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('19'),
                    onPressed: () {
                      Navigator.pop(context);
                      //hier hat player 19 gewettet
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('20'),
                    onPressed: () {
                      Navigator.pop(context);
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
