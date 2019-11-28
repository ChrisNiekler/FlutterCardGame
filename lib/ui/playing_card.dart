import 'package:flutter/material.dart';

class PlayingCard extends StatelessWidget {
  final String cardID;

  PlayingCard(this.cardID);

  //void createPlayhandCards(){

 // }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      child: Container(
          alignment: Alignment.center,
          height: 80.0,
          width: 50.0,
          child: Image.asset(
            "images/cards/$cardID.png",
            height: 80.0,
            width: 50.0,
          )),
      feedback: Container(
          alignment: Alignment.center,
          height: 80.0,
          width: 50.0,
          child: Image.asset(
            "images/cards/$cardID.png",
            height: 80.0,
            width: 50.0,
          )),
      childWhenDragging: Container(),
      data: cardID,
    );
  }
}
