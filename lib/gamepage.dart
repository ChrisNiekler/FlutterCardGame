import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wizard/cardDropField.dart';
import 'playerTemplateGUI.dart';

class Gamepage extends StatelessWidget {
  int amountPlayers;
  final String username;
  double widthDevice;
  double heightDevice;


  Gamepage({this.amountPlayers, this.username});

  @override
  Widget build(BuildContext context) {
    widthDevice = MediaQuery.of(context).size.width;
    heightDevice = MediaQuery.of(context).size.height * 7 / 10;
    return new Scaffold(
        body: SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              //mainAxisSize: MainAxisSize.max,
              children: getTableUI(),
            ),
            Row(
              children: <Widget>[
                BottomPart(),
              ],
            )
          ],
        ),
      ),
    ));
  }

//create the ui
  List<Widget> getTableUI() {
    List<Widget> playerList = [];

    playerList.add(leftPart());
    playerList.add(MidPartNew());
    playerList.add(rightPart());
    return playerList;
  }

//creates amount of players
  List<Widget> getPlayerContainerLeft() {
    List<Widget> playerCards = [];

    if (amountPlayers == 3)
      playerCards.add(PlayerTemplate(playerName: "Playername",isLeft: true,));
    if (amountPlayers >= 4) {
      playerCards.add(PlayerTemplate(playerName: "Playername",isLeft: true,));
      playerCards.add(PlayerTemplate(playerName: "Playername",isLeft: true,));
    }

    return playerCards;
  }

  List<Widget> getPlayerContainerRight() {
    List<Widget> playerCards = [];

    if (amountPlayers < 5)
      playerCards.add(PlayerTemplate(playerName: "Playername",isLeft: false,));
    if (amountPlayers == 5) {
      playerCards.add(PlayerTemplate(playerName: "Playername",isLeft: false,));
      playerCards.add(PlayerTemplate(playerName: "Playername",isLeft: false,));
    }

    return playerCards;
  }

  Widget playedTrickCard() {
    return Container(
      width: 80.0,
      height: 40.0,
      decoration: BoxDecoration(color: Colors.blueGrey),
      child: Text("TrickCard"),
    );
  }

  Widget leftPart() {
    return Container(
      height: heightDevice,
      width: widthDevice * 2 / 5,
      color: Colors.grey,
      child: Column(children: getPlayerContainerLeft()),
    );
  }

  Widget rightPart() {
    return Container(
      height: heightDevice,
      width: widthDevice * 2 / 5,
      color: Colors.grey,
      child: Column(children: getPlayerContainerRight()),
    );
  }
}

class MidPartNew extends StatefulWidget {
  @override
  _MidPartNewState createState() => _MidPartNewState();
}

class _MidPartNewState extends State<MidPartNew> {
  String cardID;
  String cardTrump;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightForFinite(
        height: MediaQuery.of(context).size.height * 7 / 10,
        width: MediaQuery.of(context).size.width * 1 / 5,
      ),
      color: Colors.grey,
      child: Column(
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

                    //Text("$cardID"),
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
        ],
      ),
    );
  }
}

class BottomPart extends StatelessWidget {
  final String cardID="";
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 3/10 -25.0,
      child: Column(
        children: <Widget>[CardDropField(cardID),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CreateCardImage('2diamonds'),
              CreateCardImage('3diamonds'),
              CreateCardImage('5spades'),
              CreateCardImage('1hearts'),
            ],
          ),
          Text("Playername")
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
  final String cardID;

  //CreateCardImage({Key key, this.offset}) : super(key: key);

  @override
  _CreateCardImageState createState() => _CreateCardImageState();

  CreateCardImage(this.cardID);
}

class _CreateCardImageState extends State<CreateCardImage> {
  String cardID;

  void changeCardID(String cardID) {
    setState(() {
      cardID = cardID;
    });
  }

  @override
  void initState() {
    super.initState();

    cardID = widget.cardID;
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
        setState(() {});
      },
    );
  }
}

class CreateCardImageBack extends StatefulWidget {
  @override
  _CreateCardImageBackState createState() => _CreateCardImageBackState();

  CreateCardImageBack();
}

class _CreateCardImageBackState extends State<CreateCardImageBack> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: RotatedBox(
          quarterTurns: 5,
          child: Image.asset(
            "images/cards/blue_back.png",
            width: 25.0,
          ),
        ));
  }
}
