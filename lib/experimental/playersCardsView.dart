import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
This widget is not used anymore.
It is replaced by usersViewWidget.
 */
Widget playersCardsView(List<Widget> playersCards) {
  return Container(
    color: Colors.red,
    child: Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: playersCards,
          ),
        ),
      ],
    ),
  );
}
