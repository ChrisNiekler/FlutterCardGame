import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
