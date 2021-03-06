import 'package:flutter/material.dart';
import 'package:wizard/logic/wizard.dart';

/*
This class shows the scoreboard with the bets and points of every player
in the game.
 */
class Scoreboard extends StatefulWidget {
  Scoreboard(this.wizard);

  Wizard wizard;

  @override
  _ScoreboardState createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  int betActual;
  int points;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 2, 0, 1),
      contentTextStyle: TextStyle(height: 2, color: Colors.black),
      title: Text('Scoreboard'),
      content: Container(
        width: 700,
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Table(
            defaultColumnWidth: FlexColumnWidth(6.0),
            border: TableBorder.all(width: 0.9, color: Colors.black),
            columnWidths: {
              0: FractionColumnWidth(.05),
              1: FractionColumnWidth(.10),
              2: FractionColumnWidth(.06),
              3: FractionColumnWidth(.10),
              4: FractionColumnWidth(.06),
              5: FractionColumnWidth(.10),
              6: FractionColumnWidth(.06),
              7: FractionColumnWidth(.10),
              8: FractionColumnWidth(.06),
              9: FractionColumnWidth(.10),
              10: FractionColumnWidth(.06),
              11: FractionColumnWidth(.10),
              12: FractionColumnWidth(.06),
            },
            children: [
              TableRow(children: [
                //0
                Text(""),
                Text("Uno"),
                Text("UB"), //UnoBet
                Text("Dos"),
                Text("DB"), //DosBet
                Text("Tres"),
                Text("TB"), //TresBet
                Text("Quat"), //Quatro
                Text("QB"), //QuatroBet
                Text("Cinc"), //Cinco
                Text("CB"), //CincoBet
                Text("Seis"),
                Text("SB"), //SeisBet
              ]),
              TableRow(children: [
                //1
                Text("1"),
                widget.wizard.roundNumber > 1
                    ? Text('${widget.wizard.getPointsFromList(0, 1)}')
                    : Text(""),
                widget.wizard.roundNumber >= 1
                    ? Text('${widget.wizard.getBetFromList(0, 1)}')
                    : Text(""),
                widget.wizard.roundNumber > 1
                    ? Text('${widget.wizard.getPointsFromList(1, 1)}')
                    : Text(""),
                widget.wizard.roundNumber >= 1
                    ? Text('${widget.wizard.getBetFromList(1, 1)}')
                    : Text(""),
                widget.wizard.roundNumber > 1
                    ? Text('${widget.wizard.getPointsFromList(2, 1)}')
                    : Text(""),
                widget.wizard.roundNumber >= 1
                    ? Text('${widget.wizard.getBetFromList(2, 1)}')
                    : Text(""),
                widget.wizard.roundNumber > 1 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getPointsFromList(3, 1)}')
                    : Text(""),
                widget.wizard.roundNumber >= 1 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getBetFromList(3, 1)}')
                    : Text(""),
                widget.wizard.roundNumber > 1 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getPointsFromList(4, 1)}')
                    : Text(""),
                widget.wizard.roundNumber >= 1 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getBetFromList(4, 1)}')
                    : Text(""),
                widget.wizard.roundNumber > 1 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getPointsFromList(5, 1)}')
                    : Text(""),
                widget.wizard.roundNumber >= 1 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getBetFromList(5, 1)}')
                    : Text(""),
              ]),
              TableRow(children: [
                //2
                Text("2"),
                widget.wizard.roundNumber > 2
                    ? Text('${widget.wizard.getPointsFromList(0, 2)}')
                    : Text(""),
                widget.wizard.roundNumber >= 2
                    ? Text('${widget.wizard.getBetFromList(0, 2)}')
                    : Text(""),
                widget.wizard.roundNumber > 2
                    ? Text('${widget.wizard.getPointsFromList(1, 2)}')
                    : Text(""),
                widget.wizard.roundNumber >= 2
                    ? Text('${widget.wizard.getBetFromList(1, 2)}')
                    : Text(""),
                widget.wizard.roundNumber > 2
                    ? Text('${widget.wizard.getPointsFromList(2, 2)}')
                    : Text(""),
                widget.wizard.roundNumber >= 2
                    ? Text('${widget.wizard.getBetFromList(2, 2)}')
                    : Text(""),
                widget.wizard.roundNumber > 2 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getPointsFromList(3, 2)}')
                    : Text(""),
                widget.wizard.roundNumber >= 2 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getBetFromList(3, 2)}')
                    : Text(""),
                widget.wizard.roundNumber > 2 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getPointsFromList(4, 2)}')
                    : Text(""),
                widget.wizard.roundNumber >= 2 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getBetFromList(4, 2)}')
                    : Text(""),
                widget.wizard.roundNumber > 2 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getPointsFromList(5, 2)}')
                    : Text(""),
                widget.wizard.roundNumber >= 2 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getBetFromList(5, 2)}')
                    : Text(""),
              ]),
              TableRow(children: [
                //3
                Text("3"),
                widget.wizard.roundNumber > 3
                    ? Text('${widget.wizard.getPointsFromList(0, 3)}')
                    : Text(""),
                widget.wizard.roundNumber >= 3
                    ? Text('${widget.wizard.getBetFromList(0, 3)}')
                    : Text(""),
                widget.wizard.roundNumber > 3
                    ? Text('${widget.wizard.getPointsFromList(1, 3)}')
                    : Text(""),
                widget.wizard.roundNumber >= 3
                    ? Text('${widget.wizard.getBetFromList(1, 3)}')
                    : Text(""),
                widget.wizard.roundNumber > 3
                    ? Text('${widget.wizard.getPointsFromList(2, 3)}')
                    : Text(""),
                widget.wizard.roundNumber >= 3
                    ? Text('${widget.wizard.getBetFromList(2, 3)}')
                    : Text(""),
                widget.wizard.roundNumber > 3 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getPointsFromList(3, 3)}')
                    : Text(""),
                widget.wizard.roundNumber >= 3 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getBetFromList(3, 3)}')
                    : Text(""),
                widget.wizard.roundNumber > 3 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getPointsFromList(4, 3)}')
                    : Text(""),
                widget.wizard.roundNumber >= 3 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getBetFromList(4, 3)}')
                    : Text(""),
                widget.wizard.roundNumber > 3 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getPointsFromList(5, 3)}')
                    : Text(""),
                widget.wizard.roundNumber >= 3 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getBetFromList(5, 3)}')
                    : Text(""),
              ]),
              TableRow(children: [
                //4
                Text("4"),
                widget.wizard.roundNumber > 4
                    ? Text('${widget.wizard.getPointsFromList(0, 4)}')
                    : Text(""),
                widget.wizard.roundNumber >= 4
                    ? Text('${widget.wizard.getBetFromList(0, 4)}')
                    : Text(""),
                widget.wizard.roundNumber > 4
                    ? Text('${widget.wizard.getPointsFromList(1, 4)}')
                    : Text(""),
                widget.wizard.roundNumber >= 4
                    ? Text('${widget.wizard.getBetFromList(1, 4)}')
                    : Text(""),
                widget.wizard.roundNumber > 4
                    ? Text('${widget.wizard.getPointsFromList(2, 4)}')
                    : Text(""),
                widget.wizard.roundNumber >= 4
                    ? Text('${widget.wizard.getBetFromList(2, 4)}')
                    : Text(""),
                widget.wizard.roundNumber > 4 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getPointsFromList(3, 4)}')
                    : Text(""),
                widget.wizard.roundNumber >= 4 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getBetFromList(3, 4)}')
                    : Text(""),
                widget.wizard.roundNumber > 4 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getPointsFromList(4, 4)}')
                    : Text(""),
                widget.wizard.roundNumber >= 4 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getBetFromList(4, 4)}')
                    : Text(""),
                widget.wizard.roundNumber > 4 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getPointsFromList(5, 4)}')
                    : Text(""),
                widget.wizard.roundNumber >= 4 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getBetFromList(5, 4)}')
                    : Text(""),
              ]),
              TableRow(children: [
                //5
                Text("5"),
                widget.wizard.roundNumber > 5
                    ? Text('${widget.wizard.getPointsFromList(0, 5)}')
                    : Text(""),
                widget.wizard.roundNumber >= 5
                    ? Text('${widget.wizard.getBetFromList(0, 5)}')
                    : Text(""),
                widget.wizard.roundNumber > 5
                    ? Text('${widget.wizard.getPointsFromList(1, 5)}')
                    : Text(""),
                widget.wizard.roundNumber >= 5
                    ? Text('${widget.wizard.getBetFromList(1, 5)}')
                    : Text(""),
                widget.wizard.roundNumber > 5
                    ? Text('${widget.wizard.getPointsFromList(2, 5)}')
                    : Text(""),
                widget.wizard.roundNumber >= 5
                    ? Text('${widget.wizard.getBetFromList(2, 5)}')
                    : Text(""),
                widget.wizard.roundNumber > 5 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getPointsFromList(3, 5)}')
                    : Text(""),
                widget.wizard.roundNumber >= 5 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getBetFromList(3, 5)}')
                    : Text(""),
                widget.wizard.roundNumber > 5 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getPointsFromList(4, 5)}')
                    : Text(""),
                widget.wizard.roundNumber >= 5 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getBetFromList(4, 5)}')
                    : Text(""),
                widget.wizard.roundNumber > 5 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getPointsFromList(5, 5)}')
                    : Text(""),
                widget.wizard.roundNumber >= 5 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getBetFromList(5, 5)}')
                    : Text(""),
              ]),
              TableRow(children: [
                //6
                Text("6"),
                widget.wizard.roundNumber > 6
                    ? Text('${widget.wizard.getPointsFromList(0, 6)}')
                    : Text(""),
                widget.wizard.roundNumber >= 6
                    ? Text('${widget.wizard.getBetFromList(0, 6)}')
                    : Text(""),
                widget.wizard.roundNumber > 6
                    ? Text('${widget.wizard.getPointsFromList(1, 6)}')
                    : Text(""),
                widget.wizard.roundNumber >= 6
                    ? Text('${widget.wizard.getBetFromList(1, 6)}')
                    : Text(""),
                widget.wizard.roundNumber > 6
                    ? Text('${widget.wizard.getPointsFromList(2, 6)}')
                    : Text(""),
                widget.wizard.roundNumber >= 6
                    ? Text('${widget.wizard.getBetFromList(2, 6)}')
                    : Text(""),
                widget.wizard.roundNumber > 6 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getPointsFromList(3, 6)}')
                    : Text(""),
                widget.wizard.roundNumber >= 6 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getBetFromList(3, 6)}')
                    : Text(""),
                widget.wizard.roundNumber > 6 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getPointsFromList(4, 6)}')
                    : Text(""),
                widget.wizard.roundNumber >= 6 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getBetFromList(4, 6)}')
                    : Text(""),
                widget.wizard.roundNumber > 6 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getPointsFromList(5, 6)}')
                    : Text(""),
                widget.wizard.roundNumber >= 6 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getBetFromList(5, 6)}')
                    : Text(""),
              ]),
              TableRow(children: [
                //7
                Text("7"),
                widget.wizard.roundNumber > 7
                    ? Text('${widget.wizard.getPointsFromList(0, 7)}')
                    : Text(""),
                widget.wizard.roundNumber >= 7
                    ? Text('${widget.wizard.getBetFromList(0, 7)}')
                    : Text(""),
                widget.wizard.roundNumber > 7
                    ? Text('${widget.wizard.getPointsFromList(1, 7)}')
                    : Text(""),
                widget.wizard.roundNumber >= 7
                    ? Text('${widget.wizard.getBetFromList(1, 7)}')
                    : Text(""),
                widget.wizard.roundNumber > 7
                    ? Text('${widget.wizard.getPointsFromList(2, 7)}')
                    : Text(""),
                widget.wizard.roundNumber >= 7
                    ? Text('${widget.wizard.getBetFromList(2, 7)}')
                    : Text(""),
                widget.wizard.roundNumber > 7 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getPointsFromList(3, 7)}')
                    : Text(""),
                widget.wizard.roundNumber >= 7 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getBetFromList(3, 7)}')
                    : Text(""),
                widget.wizard.roundNumber > 7 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getPointsFromList(4, 7)}')
                    : Text(""),
                widget.wizard.roundNumber >= 7 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getBetFromList(4, 7)}')
                    : Text(""),
                widget.wizard.roundNumber > 7 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getPointsFromList(5, 7)}')
                    : Text(""),
                widget.wizard.roundNumber >= 7 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getBetFromList(5, 7)}')
                    : Text(""),
              ]),
              TableRow(children: [
                //8
                Text("8"),
                widget.wizard.roundNumber > 8
                    ? Text('${widget.wizard.getPointsFromList(0, 8)}')
                    : Text(""),
                widget.wizard.roundNumber >= 8
                    ? Text('${widget.wizard.getBetFromList(0, 8)}')
                    : Text(""),
                widget.wizard.roundNumber > 8
                    ? Text('${widget.wizard.getPointsFromList(1, 8)}')
                    : Text(""),
                widget.wizard.roundNumber >= 8
                    ? Text('${widget.wizard.getBetFromList(1, 8)}')
                    : Text(""),
                widget.wizard.roundNumber > 8
                    ? Text('${widget.wizard.getPointsFromList(2, 8)}')
                    : Text(""),
                widget.wizard.roundNumber >= 8
                    ? Text('${widget.wizard.getBetFromList(2, 8)}')
                    : Text(""),
                widget.wizard.roundNumber > 8 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getPointsFromList(3, 8)}')
                    : Text(""),
                widget.wizard.roundNumber >= 8 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getBetFromList(3, 8)}')
                    : Text(""),
                widget.wizard.roundNumber > 8 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getPointsFromList(4, 8)}')
                    : Text(""),
                widget.wizard.roundNumber >= 8 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getBetFromList(4, 8)}')
                    : Text(""),
                widget.wizard.roundNumber > 8 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getPointsFromList(5, 8)}')
                    : Text(""),
                widget.wizard.roundNumber >= 8 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getBetFromList(5, 8)}')
                    : Text(""),
              ]),
              TableRow(children: [
                //9
                Text("9"),
                widget.wizard.roundNumber > 9
                    ? Text('${widget.wizard.getPointsFromList(0, 9)}')
                    : Text(""),
                widget.wizard.roundNumber >= 9
                    ? Text('${widget.wizard.getBetFromList(0, 9)}')
                    : Text(""),
                widget.wizard.roundNumber > 9
                    ? Text('${widget.wizard.getPointsFromList(1, 9)}')
                    : Text(""),
                widget.wizard.roundNumber >= 9
                    ? Text('${widget.wizard.getBetFromList(1, 9)}')
                    : Text(""),
                widget.wizard.roundNumber > 9
                    ? Text('${widget.wizard.getPointsFromList(2, 9)}')
                    : Text(""),
                widget.wizard.roundNumber >= 9
                    ? Text('${widget.wizard.getBetFromList(2, 9)}')
                    : Text(""),
                widget.wizard.roundNumber > 9 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getPointsFromList(3, 9)}')
                    : Text(""),
                widget.wizard.roundNumber >= 9 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getBetFromList(3, 9)}')
                    : Text(""),
                widget.wizard.roundNumber > 9 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getPointsFromList(4, 9)}')
                    : Text(""),
                widget.wizard.roundNumber >= 9 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getBetFromList(4, 9)}')
                    : Text(""),
                widget.wizard.roundNumber > 9 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getPointsFromList(5, 9)}')
                    : Text(""),
                widget.wizard.roundNumber >= 9 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getBetFromList(5, 9)}')
                    : Text(""),
              ]),
              TableRow(children: [
                //10
                Text("10"),
                widget.wizard.roundNumber > 10
                    ? Text('${widget.wizard.getPointsFromList(0, 10)}')
                    : Text(""),
                widget.wizard.roundNumber >= 10
                    ? Text('${widget.wizard.getBetFromList(0, 10)}')
                    : Text(""),
                widget.wizard.roundNumber > 10
                    ? Text('${widget.wizard.getPointsFromList(1, 10)}')
                    : Text(""),
                widget.wizard.roundNumber >= 10
                    ? Text('${widget.wizard.getBetFromList(1, 10)}')
                    : Text(""),
                widget.wizard.roundNumber > 10
                    ? Text('${widget.wizard.getPointsFromList(2, 10)}')
                    : Text(""),
                widget.wizard.roundNumber >= 10
                    ? Text('${widget.wizard.getBetFromList(2, 10)}')
                    : Text(""),
                widget.wizard.roundNumber > 10 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getPointsFromList(3, 10)}')
                    : Text(""),
                widget.wizard.roundNumber >= 10 &&
                        widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getBetFromList(3, 10)}')
                    : Text(""),
                widget.wizard.roundNumber > 10 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getPointsFromList(4, 10)}')
                    : Text(""),
                widget.wizard.roundNumber >= 10 &&
                        widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getBetFromList(4, 10)}')
                    : Text(""),
                widget.wizard.roundNumber > 10 && widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getPointsFromList(5, 10)}')
                    : Text(""),
                widget.wizard.roundNumber >= 10 &&
                        widget.wizard.playerAmount > 5
                    ? Text('${widget.wizard.getBetFromList(5, 10)}')
                    : Text(""),
              ]),
              TableRow(children: [
                //11
                Text("11"),
                widget.wizard.roundNumber > 11
                    ? Text('${widget.wizard.getPointsFromList(0, 11)}')
                    : Text(""),
                widget.wizard.lastRound != 10 && widget.wizard.roundNumber >= 11
                    ? Text('${widget.wizard.getBetFromList(0, 11)}')
                    : Text(""),
                widget.wizard.roundNumber > 11
                    ? Text('${widget.wizard.getPointsFromList(1, 11)}')
                    : Text(""),
                widget.wizard.lastRound != 10 && widget.wizard.roundNumber >= 11
                    ? Text('${widget.wizard.getBetFromList(1, 11)}')
                    : Text(""),
                widget.wizard.roundNumber > 11
                    ? Text('${widget.wizard.getPointsFromList(2, 11)}')
                    : Text(""),
                widget.wizard.lastRound != 10 && widget.wizard.roundNumber >= 11
                    ? Text('${widget.wizard.getBetFromList(2, 11)}')
                    : Text(""),
                widget.wizard.roundNumber > 11 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getPointsFromList(3, 11)}')
                    : Text(""),
                widget.wizard.lastRound != 10 &&
                        widget.wizard.roundNumber >= 11 &&
                        widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getBetFromList(3, 11)}')
                    : Text(""),
                widget.wizard.roundNumber > 11 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getPointsFromList(4, 11)}')
                    : Text(""),
                widget.wizard.lastRound != 10 &&
                        widget.wizard.roundNumber >= 11 &&
                        widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getBetFromList(4, 11)}')
                    : Text(""),
                Text(""),
                Text(""),
              ]),
              TableRow(children: [
                //12
                Text("12"),
                widget.wizard.roundNumber > 12
                    ? Text('${widget.wizard.getPointsFromList(0, 12)}')
                    : Text(""),
                widget.wizard.roundNumber >= 12
                    ? Text('${widget.wizard.getBetFromList(0, 12)}')
                    : Text(""),
                widget.wizard.roundNumber > 12
                    ? Text('${widget.wizard.getPointsFromList(1, 12)}')
                    : Text(""),
                widget.wizard.roundNumber >= 12
                    ? Text('${widget.wizard.getBetFromList(1, 12)}')
                    : Text(""),
                widget.wizard.roundNumber > 12
                    ? Text('${widget.wizard.getPointsFromList(2, 12)}')
                    : Text(""),
                widget.wizard.roundNumber >= 12
                    ? Text('${widget.wizard.getBetFromList(2, 12)}')
                    : Text(""),
                widget.wizard.roundNumber > 12 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getPointsFromList(3, 12)}')
                    : Text(""),
                widget.wizard.roundNumber >= 12 &&
                        widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getBetFromList(3, 12)}')
                    : Text(""),
                widget.wizard.roundNumber > 12 && widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getPointsFromList(4, 12)}')
                    : Text(""),
                widget.wizard.roundNumber >= 12 &&
                        widget.wizard.playerAmount > 4
                    ? Text('${widget.wizard.getBetFromList(4, 12)}')
                    : Text(""),
                Text(""),
                Text(""),
              ]),
              TableRow(children: [
                //13
                Text("13"),
                widget.wizard.roundNumber > 13
                    ? Text('${widget.wizard.getPointsFromList(0, 13)}')
                    : Text(""),
                widget.wizard.lastRound != 12 && widget.wizard.roundNumber >= 13
                    ? Text('${widget.wizard.getBetFromList(0, 13)}')
                    : Text(""),
                widget.wizard.roundNumber > 13
                    ? Text('${widget.wizard.getPointsFromList(1, 13)}')
                    : Text(""),
                widget.wizard.lastRound != 12 && widget.wizard.roundNumber >= 13
                    ? Text('${widget.wizard.getBetFromList(1, 13)}')
                    : Text(""),
                widget.wizard.roundNumber > 13
                    ? Text('${widget.wizard.getPointsFromList(2, 13)}')
                    : Text(""),
                widget.wizard.lastRound != 12 && widget.wizard.roundNumber >= 13
                    ? Text('${widget.wizard.getBetFromList(2, 13)}')
                    : Text(""),
                widget.wizard.roundNumber > 13 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getPointsFromList(3, 13)}')
                    : Text(""),
                widget.wizard.lastRound != 12 &&
                        widget.wizard.roundNumber >= 13 &&
                        widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getBetFromList(3, 13)}')
                    : Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
              ]),
              TableRow(children: [
                //14
                Text("14"),
                widget.wizard.roundNumber > 14
                    ? Text('${widget.wizard.getPointsFromList(0, 14)}')
                    : Text(""),
                widget.wizard.roundNumber >= 14
                    ? Text('${widget.wizard.getBetFromList(0, 14)}')
                    : Text(""),
                widget.wizard.roundNumber > 14
                    ? Text('${widget.wizard.getPointsFromList(1, 14)}')
                    : Text(""),
                widget.wizard.roundNumber >= 14
                    ? Text('${widget.wizard.getBetFromList(1, 14)}')
                    : Text(""),
                widget.wizard.roundNumber > 14
                    ? Text('${widget.wizard.getPointsFromList(2, 14)}')
                    : Text(""),
                widget.wizard.roundNumber >= 14
                    ? Text('${widget.wizard.getBetFromList(2, 14)}')
                    : Text(""),
                widget.wizard.roundNumber > 14 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getPointsFromList(3, 14)}')
                    : Text(""),
                widget.wizard.roundNumber >= 14 &&
                        widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getBetFromList(3, 14)}')
                    : Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
              ]),
              TableRow(children: [
                //15
                Text("15"),
                widget.wizard.roundNumber > 15
                    ? Text('${widget.wizard.getPointsFromList(0, 15)}')
                    : Text(""),
                widget.wizard.roundNumber >= 15
                    ? Text('${widget.wizard.getBetFromList(0, 15)}')
                    : Text(""),
                widget.wizard.roundNumber > 15
                    ? Text('${widget.wizard.getPointsFromList(1, 15)}')
                    : Text(""),
                widget.wizard.roundNumber >= 15
                    ? Text('${widget.wizard.getBetFromList(1, 15)}')
                    : Text(""),
                widget.wizard.roundNumber > 15
                    ? Text('${widget.wizard.getPointsFromList(2, 15)}')
                    : Text(""),
                widget.wizard.roundNumber >= 15
                    ? Text('${widget.wizard.getBetFromList(2, 15)}')
                    : Text(""),
                widget.wizard.roundNumber > 15 && widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getPointsFromList(3, 15)}')
                    : Text(""),
                widget.wizard.roundNumber >= 15 &&
                        widget.wizard.playerAmount > 3
                    ? Text('${widget.wizard.getBetFromList(3, 15)}')
                    : Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
              ]),
              TableRow(children: [
                //16
                Text("16"),
                widget.wizard.roundNumber > 16
                    ? Text('${widget.wizard.getPointsFromList(0, 16)}')
                    : Text(""),
                widget.wizard.lastRound != 15 && widget.wizard.roundNumber >= 16
                    ? Text('${widget.wizard.getBetFromList(0, 16)}')
                    : Text(""),
                widget.wizard.roundNumber > 16
                    ? Text('${widget.wizard.getPointsFromList(1, 16)}')
                    : Text(""),
                widget.wizard.lastRound != 15 && widget.wizard.roundNumber >= 16
                    ? Text('${widget.wizard.getBetFromList(1, 16)}')
                    : Text(""),
                widget.wizard.roundNumber > 16
                    ? Text('${widget.wizard.getPointsFromList(2, 16)}')
                    : Text(""),
                widget.wizard.lastRound != 15 && widget.wizard.roundNumber >= 16
                    ? Text('${widget.wizard.getBetFromList(2, 16)}')
                    : Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
              ]),
              TableRow(children: [
                //17
                Text("17"),
                widget.wizard.roundNumber > 17
                    ? Text('${widget.wizard.getPointsFromList(0, 17)}')
                    : Text(""),
                widget.wizard.roundNumber >= 17
                    ? Text('${widget.wizard.getBetFromList(0, 17)}')
                    : Text(""),
                widget.wizard.roundNumber > 17
                    ? Text('${widget.wizard.getPointsFromList(1, 17)}')
                    : Text(""),
                widget.wizard.roundNumber >= 17
                    ? Text('${widget.wizard.getBetFromList(1, 17)}')
                    : Text(""),
                widget.wizard.roundNumber > 17
                    ? Text('${widget.wizard.getPointsFromList(2, 17)}')
                    : Text(""),
                widget.wizard.roundNumber >= 17
                    ? Text('${widget.wizard.getBetFromList(2, 17)}')
                    : Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
              ]),
              TableRow(children: [
                //18
                Text("18"),
                widget.wizard.roundNumber > 18
                    ? Text('${widget.wizard.getPointsFromList(0, 18)}')
                    : Text(""),
                widget.wizard.roundNumber >= 18
                    ? Text('${widget.wizard.getBetFromList(0, 18)}')
                    : Text(""),
                widget.wizard.roundNumber > 18
                    ? Text('${widget.wizard.getPointsFromList(1, 18)}')
                    : Text(""),
                widget.wizard.roundNumber >= 18
                    ? Text('${widget.wizard.getBetFromList(1, 18)}')
                    : Text(""),
                widget.wizard.roundNumber > 18
                    ? Text('${widget.wizard.getPointsFromList(2, 18)}')
                    : Text(""),
                widget.wizard.roundNumber >= 18
                    ? Text('${widget.wizard.getBetFromList(2, 18)}')
                    : Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
              ]),
              TableRow(children: [
                //19
                Text("19"),
                widget.wizard.roundNumber > 19
                    ? Text('${widget.wizard.getPointsFromList(0, 19)}')
                    : Text(""),
                widget.wizard.roundNumber >= 19
                    ? Text('${widget.wizard.getBetFromList(0, 19)}')
                    : Text(""),
                widget.wizard.roundNumber > 19
                    ? Text('${widget.wizard.getPointsFromList(1, 19)}')
                    : Text(""),
                widget.wizard.roundNumber >= 19
                    ? Text('${widget.wizard.getBetFromList(1, 19)}')
                    : Text(""),
                widget.wizard.roundNumber > 19
                    ? Text('${widget.wizard.getPointsFromList(2, 19)}')
                    : Text(""),
                widget.wizard.roundNumber >= 19
                    ? Text('${widget.wizard.getBetFromList(2, 19)}')
                    : Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
              ]),
              TableRow(children: [
                //20
                Text("20"),
                widget.wizard.roundNumber > 20
                    ? Text('${widget.wizard.getPointsFromList(0, 20)}')
                    : Text(""),
                widget.wizard.roundNumber >= 20
                    ? Text('${widget.wizard.getBetFromList(0, 20)}')
                    : Text(""),
                widget.wizard.roundNumber > 20
                    ? Text('${widget.wizard.getPointsFromList(1, 20)}')
                    : Text(""),
                widget.wizard.roundNumber >= 20
                    ? Text('${widget.wizard.getBetFromList(1, 20)}')
                    : Text(""),
                widget.wizard.roundNumber > 20
                    ? Text('${widget.wizard.getPointsFromList(2, 20)}')
                    : Text(""),
                widget.wizard.roundNumber >= 20
                    ? Text('${widget.wizard.getBetFromList(2, 20)}')
                    : Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
