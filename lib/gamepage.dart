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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.black12,
                  height: 500.0,
                  width: 100,
                  alignment: Alignment.center,
                  child: Text("Spieler 1"),
                ),
                Container(
                  width: 200.0,
                  height: 100.0,
                  color: Colors.green,
                  alignment: Alignment.center,
                  child: DragTarget(
                    builder: (context, List<AssetImage> candidateData,
                        rejectedData) {
                      print(candidateData);
                      return Center(
                          child: Text(
                            "Trumpf",
                            style: TextStyle(color: Colors.white, fontSize: 22.0),
                          ));
                    },
                    onWillAccept: (data) {
                      return true;
                    },
                    onAccept: (data) {},
                  ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Draggable(
                    data: 5,
                    child: Container(
                      alignment: Alignment.center,
                      height: 100.0,
                      width: 80.0,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: new AssetImage('images/cards/2D.png'),
                          fit: BoxFit.fill,
                        ),

                      ),
                    ),
                    feedback: Container(
                      alignment: Alignment.center,
                      height: 100.0,
                      width: 80.0,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: new AssetImage('images/cards/2D.png'),
                          fit: BoxFit.fill,
                        ),

                      ),
                    ),
                    childWhenDragging: Container(),
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
