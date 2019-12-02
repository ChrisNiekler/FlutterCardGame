import 'package:flutter/material.dart';
import 'package:wizard/consoleGame/round.dart';

//for the trump, still need to extend this for the 6th player
class MidPart extends StatefulWidget {
  final Card trump;

  MidPart({this.trump});

  @override
  _MidPartState createState() => _MidPartState();
}

class _MidPartState extends State<MidPart> {
  String cardID;
  String cardTrump;
  Round round;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightForFinite(
        //  height: MediaQuery.of(context).size.height * 6 / 10,
        width: MediaQuery.of(context).size.width * 1 / 5,
      ),
      color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DragTarget(
            builder: (context, List<String> acceptedCards, rejectedCards) {
              print(acceptedCards);
              return Container(
                height: 150.0,
                width: 100.0,
                color: Colors.white70,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Trump',
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                    //cardID == null ? Container() : CreateCardImage('$cardID'),
                    cardID == null
                        ? Container()
                        : Container(
                            width: 40.0,
                            height: 80.0,
                            child: Image.asset("images/cards/$cardID.png"),
                          )
                  ],
                ),
              );
            },
            onWillAccept: (data) {
              return true;
            },
            onAccept: (data) {
              setState(() {
                cardID = data;
              });
            },
          ),
          /* Column(mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              CardDropField(cardID),
            ],
          )*/
        ],
      ),
    );
  }
}
//for trump from round class
/*                    round.trumpCard.toString() == null
                        ? Container()
                        : Container(
                            width: 40.0,
                            height: 80.0,
                            child: Image.asset("images/cards/${round.trumpCard.toString()}.png"),
                          )
*/
