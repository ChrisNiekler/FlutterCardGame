import 'package:flutter/cupertino.dart';
import 'package:wizard/logic/card.dart' as logic;

Widget cardOnTable(Color bgcolor, logic.Card playerField) {
  return Expanded(
    child: Container(
      color: bgcolor,
      child: Center(
          child: (playerField != null) ? playedCard(playerField) : Container()),
    ),
  );
}

Widget playedCard(logic.Card tCard) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: tCard.playerCardsWidget(),
  );
}
