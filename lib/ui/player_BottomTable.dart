import 'package:flutter/material.dart';
import 'package:wizard/ui/cardDropField.dart';
import 'package:wizard/ui/playing_card.dart';
import 'package:wizard/ui/playerTemplateGUI.dart';
import 'package:wizard/logic/humanPlayer.dart';

//this is for the user able to see his cards and play from here
class BottomPart extends StatelessWidget {
  BottomPart({this.cardID});

  final String cardID;
  final List<PlayingCard> cardList = [
    PlayingCard('2diamonds'),
    PlayingCard('3diamonds'),
    PlayingCard('5spades'),
    PlayingCard('10hearts'),
  ];

  final PlayerTemplate player = PlayerTemplate();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height * 2 / 10 - 25.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          CardDropField(cardID, player),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: player.cardsPerRoundPlayer()),
        ],
      ),
    );
  }
}
