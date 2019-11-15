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
        child: Column(children: cardsPerRound()),
      ),
    );
  }

  int round = 2;

  List<CreateCardImageBack> cardsPerRound() {
    List<CreateCardImageBack> cardList = [];
    for (int i = 0; i < round; i++)
      cardList.add(CreateCardImageBack(Offset(100.0, 100.0)));
    return cardList;
  }
}
