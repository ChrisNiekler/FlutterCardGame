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
        child: Column(children: cardsPerRoundFoe()),
      ),
    );
  }

  int round = 4;

  List<CreateCardImageBack> cardsPerRoundFoe() {
    List<CreateCardImageBack> cardList = [];
    for (int i = 0; i < round; i++)
      cardList.add(CreateCardImageBack());
    return cardList;
  }
  List<CreateCardImage> cardsPerRoundPlayer(String cardID) {
    List<CreateCardImage> cardList = [];
    for (int i = 0; i < round; i++)
      cardList.add(CreateCardImage(cardID));
    return cardList;
  }
}
