import 'package:flutter/material.dart';
import 'gamepage.dart';

class PlayerTemplate extends StatelessWidget {
  final String playerName;

  PlayerTemplate({this.playerName});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Row(children: <Widget>[
        Container(
          color: Colors.grey,
          child: Row(
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: cardsPerRoundFoe()),
            ],
          ),
        ),
        Container(
          width: 60.0,
          height: 40.0,
          child: RotatedBox(
              quarterTurns: 5, child: Image.asset("images/cards/1hearts.png")),
        )
      ]),
    );
  }

  int round = 2;

  List<CreateCardImageBack> cardsPerRoundFoe() {
    List<CreateCardImageBack> cardList = [];
    for (int i = 0; i < round; i++) cardList.add(CreateCardImageBack());
    return cardList;
  }

  List<CreateCardImage> cardsPerRoundPlayer(String cardID) {
    List<String> cardID = [];
    cardID[0] = "1hearts";
    cardID[1] = "2diamonds";
    cardID[2] = "5clubs";
    cardID[3] = "6spades";
    List<CreateCardImage> cardList = [];
    for (int i = 0; i < round; i++) cardList.add(CreateCardImage(cardID[i]));
    return cardList;
  }
}
