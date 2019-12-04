import 'package:flutter/cupertino.dart';
import 'package:wizard/logic/card.dart' as logic;

Widget cardOnTable(logic.Card playerField, {bool trumpCard}) {
  Widget _out_widget;
  if (trumpCard == null) {
    return Expanded(
      child: Container(
        child: Center(
            child:
                (playerField != null) ? _playedCard(playerField) : Container()),
      ),
    );
  }
}

Widget _content() {}

Widget _playedCard(logic.Card tCard) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: tCard.playerCardsWidget(),
  );
}