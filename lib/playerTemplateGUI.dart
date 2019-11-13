import 'package:flutter/material.dart';
import 'gamepage.dart';

class PlayerTemplate extends StatelessWidget {
  final String playerName;

  PlayerTemplate({this.playerName});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        height: 500.0,
        width: 100.0,
        color: Colors.grey,
        child: Column(
          children: <Widget>[
            Text("$playerName"),
            CreateCardImageBack(Offset(100.0, 100.0)),
            CreateCardImageBack(Offset(100.0, 100.0)),
            CreateCardImageBack(Offset(100.0, 100.0)),

          ],
        ),
      ),
    );
  }

}
