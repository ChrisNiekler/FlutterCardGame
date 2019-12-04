import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

AlertDialog scoretable(BuildContext context) {
  return AlertDialog(
    content: Container(
      height: 70,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
//          color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 3,
            spreadRadius: 6,
          )
        ],
      ),
      child: Text("Hier sollte das Scoreboard sein!!!"),
    ),
  );
}
