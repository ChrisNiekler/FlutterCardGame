import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wizard/logic/gamecard.dart' as logic;

Widget cardOnTable(logic.GameCard playerField, {bool trumpCard}) {
  if (trumpCard == true) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(25.0)),
        child: Center(
            child:
                (playerField != null) ? _playedCard(playerField) : Container()),
      ),
    );
  } else {
    return Expanded(
      child: Container(
        child: Center(
            child:
                (playerField != null) ? _playedCard(playerField) : Container()),
      ),
    );
  }
}

Widget _playedCard(logic.GameCard tCard) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: tCard.playerCardsWidget(),
  );
}
