import 'package:flutter/material.dart';
import 'package:wizard/ui/playerTemplateGUI.dart';

class TopPart extends StatefulWidget {
  @override
  _TopPartState createState() => _TopPartState();
}

class _TopPartState extends State<TopPart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: PlayerTemplate().cardsPerRoundFoe()),
        Container(
          width: 40.0,
          height: 70.0,
          child: RotatedBox(
              quarterTurns: 10,
              child: Image.asset("images/cards/1hearts.png")),
        )
      ]),
    );
  }
}
