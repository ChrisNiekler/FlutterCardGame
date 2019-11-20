import 'package:flutter/material.dart';

class CardDropField extends StatefulWidget {
  final String cardID;

  @override
  _CardDropField createState() => _CardDropField();

  CardDropField(this.cardID);
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
            height: 80.0,
            width: 50.0,
            color: Colors.white70,
            alignment: Alignment.center,
            child: cardID == null
                ? Container()
                : Container(
                    height: 80.0,
                    width: 50.0,
                    child: Image.asset("images/cards/$cardID.png"),
                  )

            //Text("$cardID"),

            );
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        setState(() {
          cardID = data;
        });
      },
    );
  }
}
