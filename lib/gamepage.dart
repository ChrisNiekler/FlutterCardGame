import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wizard/round.dart';
import 'playerTemplateGUI.dart';


class Gamepage extends StatelessWidget {
  int amountPlayers;

  Gamepage({this.amountPlayers});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: getPlayers(),
                ),
                Row(
                  children: <Widget>[
                    Expanded(flex: 2, child: BottomPart()),
                  ],
                )
              ],
            ),
          ),
        ));

  }
//create the ui
List <Widget> getPlayers(){
    List<Widget>playerList =[];
   /* for(var i=0;i<1;i++){
      playerList.add(leftPart());
    }*/
    
    /*if(amountPlayers==3)
     { playerList.add(leftPart());
    playerList.add(MidPartNew());
     playerList.add(rightPart());}
    if(amountPlayers==5)
      playerList.add(leftPart());*/

    playerList.add(leftPart());
    playerList.add(MidPartNew());
    playerList.add(rightPart());
return playerList;
}
//creates amount of players
List<Widget>getPlayerCards(){
    List<Widget>playerCards =[];
    /*for(int i=0;i<round;i++)
      {
        playerCards.add(PlayerTemplate(playerName: "Playername"));
      }*/
    if(amountPlayers==3)
      playerCards.add(PlayerTemplate(playerName: "Playername"));
   if(amountPlayers>=4) {
     playerCards.add(PlayerTemplate(playerName: "Playername"));
     playerCards.add(PlayerTemplate(playerName: "Playername"));
   }


    return playerCards;
}
  List<Widget>getPlayerCardsRight(){
    List<Widget>playerCards =[];
    /*for(int i=0;i<round;i++)
      {
        playerCards.add(PlayerTemplate(playerName: "Playername"));
      }*/
    if(amountPlayers<5)
      playerCards.add(PlayerTemplate(playerName: "Playername"));
    if(amountPlayers==5) {
      playerCards.add(PlayerTemplate(playerName: "Playername"));
      playerCards.add(PlayerTemplate(playerName: "Playername"));
    }


    return playerCards;
  }

  Widget leftPart() {
    return Container(
      height: 500.0,
      width: 100.0,
      color: Colors.grey,
      child: Column(
        children: getPlayerCards()
      ),
    );
  }

  Widget rightPart() {
    return Container(
      height: 500.0,
      width: 100.0,
      color: Colors.grey,
      child: Column(
        children:getPlayerCardsRight()
      ),
    );
  }



}


/*class MidPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightForFinite(
        height: 500.0,
        width: 211.4,
      ),
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Mid"),
          DragTarget(
            builder: (context, List<String> acceptedCards, rejectedCards) {
              print(acceptedCards);
              return Container(
                height: 300.0,
                width: 200.0,
                color: Colors.white70,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Trump",
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    )
                  ],
                ),
              );
            },
            onWillAccept: (data) {
              return true;
            },
            onAccept: (data) {},
          ),
        ],
      ),
    );
  }
}*/

class MidPartNew extends StatefulWidget {
  @override
  _MidPartNewState createState() => _MidPartNewState();
}

class _MidPartNewState extends State<MidPartNew> {
  int counter = 0;
  String cardID;
  Round round;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightForFinite(
        height: 500.0,
        width: 211.4,
      ),
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Mid"),
          DragTarget(
            builder: (context, List<String> acceptedCards, rejectedCards) {
              print(acceptedCards);
              return Container(
                height: 300.0,
                width: 200.0,
                color: Colors.white70,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Trump',
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                    CreateCardImage(Offset(100.0, 100.0), '$cardID'),
                    //not working
                    Text("$cardID"),
                    TrickCard('$cardID')
                  ],
                ),
              );
            },
            onWillAccept: (data) {
              if (data == null)
                return false;
              else
                return true;
            },
            onAccept: (data) {
              setState(() {
                cardID = data;
              });
            },
          ),
        ],
      ),
    );
  }
}

class BottomPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 159,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CreateCardImage(Offset(100.0, 100.0), '2D'),
              CreateCardImage(Offset(100.0, 100.0), '3D'),
              CreateCardImage(Offset(100.0, 100.0), '5S'),
              CreateCardImage(Offset(100.0, 100.0), 'AH'),
            ],
          ), Text("Playername")
        ],
      ),
    );
  }
}

class TrickCard extends StatefulWidget {
  final String cardID;

  @override
  _TrickCardState createState() => _TrickCardState();

  TrickCard(this.cardID);
}

class _TrickCardState extends State<TrickCard> {
  String cardID;

  @override
  void initState() {
    super.initState();

    cardID = widget.cardID;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 80.0,
        width: 50.0,
        child: Image.asset(
          "images/cards/$cardID.png",
          height: 80.0,
          width: 50.0,
        ));
  }
}

class CreateCardImage extends StatefulWidget {
  final Offset offset;
  final String cardId;

  //CreateCardImage({Key key, this.offset}) : super(key: key);

  @override
  _CreateCardImageState createState() => _CreateCardImageState();

  CreateCardImage(this.offset, this.cardId);
}

class _CreateCardImageState extends State<CreateCardImage> {
  Offset offset = Offset(0.0, 0.0);
  String cardID;

  @override
  void initState() {
    super.initState();
    offset = widget.offset;
    cardID = widget.cardId;
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      child: Container(
          alignment: Alignment.center,
          height: 80.0,
          width: 50.0,
          child: Image.asset(
            "images/cards/$cardID.png",
            height: 80.0,
            width: 50.0,
          )),
      feedback: Container(
          alignment: Alignment.center,
          height: 80.0,
          width: 50.0,
          child: Image.asset(
            "images/cards/$cardID.png",
            height: 80.0,
            width: 50.0,
          )),
      childWhenDragging: Container(),
      data: cardID,
      onDraggableCanceled: (v, o) {
        setState(() {
          offset = o;
        });
      },
    );
  }
}

class CreateCardImageBack extends StatefulWidget {
  final Offset offset;

  @override
  _CreateCardImageBackState createState() => _CreateCardImageBackState();

  CreateCardImageBack(this.offset);
}

class _CreateCardImageBackState extends State<CreateCardImageBack> {
  Offset offset = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    offset = widget.offset;
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      child: Container(
          margin: EdgeInsets.all(10.0),
          child: RotatedBox(
            quarterTurns: 5,
            child: Image.asset(
              "images/cards/blue_back.png",
              width: 25.0,
            ),
          )),
      feedback: Container(
        margin: EdgeInsets.all(10.0),
        width: 25.0,
        child: RotatedBox(
          quarterTurns: 5,
          child: Image.asset(
            "images/cards/blue_back.png",
            height: 80.0,
            width: 50.0,
          ),
        ),
      ),
      childWhenDragging: Container(),
      onDraggableCanceled: (v, o) {
        setState(() {
          offset = o;
        });
      },
    );
  }
}
