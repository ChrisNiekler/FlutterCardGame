import 'package:flutter/material.dart';

/*
This widget shows the humanPlayer her/his cards.
 */
Widget playersCardsView(List<Widget> tempCards) {
  List<Widget> listA = [];
  List<Widget> listB = [];
  int k = 0;
  if (tempCards.length > 10) {
    for (; k < tempCards.length / 2; k++) {
      listA.add(tempCards[k]);
    }
    for (int j = tempCards.length; k < j; k++) {
      listB.add(tempCards[k]);
    }
  } else {
    listA = tempCards;
  }
  return Container(
    color: Colors.green.shade700,
    child: Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: listA,
          ),
        ),
        tempCards.length > 10
            ? Expanded(
                child: Row(
                  children: listB,
                ),
              )
            : Container(),
      ],
    ),
  );
}
