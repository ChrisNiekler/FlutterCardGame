import 'package:flutter/material.dart';
import 'package:wizard/ui/playerTemplateGUI.dart';

class CardDropField extends StatefulWidget {
  final String cardID;
  final PlayerTemplate player;

  @override
  _CardDropField createState() => _CardDropField();

  CardDropField(this.cardID, this.player);
}

class _CardDropField extends State<CardDropField> {
  String cardID;
  String cardTrump;

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, List<String> acceptedCards, rejectedCards) {
        print(acceptedCards);
        return Container(
            height: 70.0,
            width: 50.0,
            color: Colors.white70,
            alignment: Alignment.center,
            child: cardID == null
                ? Container()
                : Container(
                    height: 70.0,
                    width: 50.0,
                    child: Image.asset("images/cards/$cardID.png"),
                  ));
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        cardID = data;
        setState(() {
          widget.player.removePlayedCard(cardID);
        });
      },
    );
  }
}
