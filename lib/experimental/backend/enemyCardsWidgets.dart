import 'package:flutter/cupertino.dart';

Widget upsideDownCardsSides(int amountOfCards, String color) {
  List<Widget> cardListA = [];
  List<Widget> cardListB = [];
  for (int i = 0; i < amountOfCards; i++) {
    if (i < amountOfCards / 2 || amountOfCards < 11) {
      cardListA.add(
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: RotatedBox(
                quarterTurns: 5,
                child: Image.asset("images/cards/${color}_back.png"),
              ),
            ),
          ),
        ),
      );
    } else {
      cardListB.add(
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: RotatedBox(
                quarterTurns: 5,
                child: Image.asset("images/cards/${color}_back.png"),
              ),
            ),
          ),
        ),
      );
    }
  }
  return Row(
    children: <Widget>[
      Expanded(child: Column(children: cardListA)),
      amountOfCards > 10
          ? Expanded(child: Column(children: cardListB))
          : Container()
    ],
  );
}

Widget upsideDownCardsTop(int amountOfCards, String color) {
  List<Widget> cardListA = [];
  List<Widget> cardListB = [];
  for (int i = 0; i < amountOfCards; i++) {
    if (i < amountOfCards / 2 || amountOfCards < 11) {
      cardListA.add(
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Image.asset("images/cards/${color}_back.png"),
            ),
          ),
        ),
      );
    } else {
      cardListB.add(
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Image.asset("images/cards/${color}_back.png"),
            ),
          ),
        ),
      );
    }
  }
  return Column(
    children: <Widget>[
      Expanded(child: Row(children: cardListA)),
      amountOfCards > 10
          ? Expanded(child: Row(children: cardListB))
          : Container()
    ],
  );
}
