import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gamepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(

                  color: Colors.black12,
                  height: 500.0,
                  width: 100,
                  alignment: Alignment.center,
                  child: Text("Spieler 1"),
                ),
                Container(
                  color: Colors.white,
                  height: 500.0,
                  width: 210.0,
                  child: Text("Trumpf"),
                  alignment: Alignment.center,
                ),
                Expanded(
                  child: Container(

                    color: Colors.black12,
                    height: 500.0,
                    width: 100.0,
                    alignment: Alignment.center,
                    child: Text("Spieler 2"),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(children: <Widget>[

                   Expanded(
                     child: Container(
                      color: Colors.black26,

                     alignment: Alignment.center,
                      child: Text("Spieler 3"),
                  ),
                   ),

              ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
