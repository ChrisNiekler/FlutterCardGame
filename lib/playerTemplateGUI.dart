import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wizard/playing_card.dart';
import 'gamepage.dart';

class PlayerTemplate extends StatefulWidget {
  final String playerName;
  final bool isLeft;

  PlayerTemplate({this.playerName, this.isLeft});

  int round = 2;

  List<CreateCardImageBack> cardsPerRoundFoe() {
    List<CreateCardImageBack> cardList = [];
    for (int i = 0; i < round; i++) cardList.add(CreateCardImageBack());
    return cardList;
  }

  List<PlayingCard> cardsPerRoundPlayer() {
    List<String> cardID = [];
    cardID[0] = "1hearts";
    cardID[1] = "2diamonds";
    cardID[2] = "5clubs";
    cardID[3] = "10spades";
    List<PlayingCard> cardList = [];
    for (int i = 0; i < round; i++) cardList.add(PlayingCard(cardID[i]));
    return cardList;
  }

  void removePlayedCard(String card) {
    cardsPerRoundPlayer().remove(card);
  }

  @override
  _PlayerTemplateState createState() => _PlayerTemplateState();
}

class _PlayerTemplateState extends State<PlayerTemplate> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget.isLeft
            ? Expanded(
                flex: 1,
                child: Row(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: widget.cardsPerRoundFoe()),
                    ],
                  ),
                  Container(
                    width: 60.0,
                    height: 40.0,
                    child: RotatedBox(
                        quarterTurns: 5,
                        child: Image.asset("images/cards/1hearts.png")),
                  )
                ]))
            : Expanded(
                flex: 6,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 60.0,
                        height: 40.0,
                        child: RotatedBox(
                            quarterTurns: 5,
                            child: Image.asset("images/cards/1hearts.png")),
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: widget.cardsPerRoundFoe()),
                        ],
                      )
                    ])));
  }
}
