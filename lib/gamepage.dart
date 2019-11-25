import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wizard/cardDropField.dart';
import 'package:wizard/playing_card.dart';
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
    playerList.add(MidPart());
    playerList.add(rightPart());
    return playerList;
  }

//creates 1 or 2 players on the left table
  List<Widget> getPlayerContainerLeft() {
    List<Widget> playerCards = [];

    if (amountPlayers == 3)
      playerCards.add(PlayerTemplate(
        playerName: "Playername",
        isLeft: true,
      ));
    if (amountPlayers >= 4) {
      playerCards.add(PlayerTemplate(
        playerName: "Playername",
        isLeft: true,
      ));
      playerCards.add(PlayerTemplate(
        playerName: "Playername",
        isLeft: true,
      ));
    }

    return playerCards;
  }

//creates 1 or 2 player on the right
  List<Widget> getPlayerContainerRight() {
    List<Widget> playerCards = [];

    if (amountPlayers < 5)
      playerCards.add(PlayerTemplate(
        playerName: "Playername",
        isLeft: false,
      ));
    if (amountPlayers == 5) {
      playerCards.add(PlayerTemplate(
        playerName: "Playername",
        isLeft: false,
      ));
      playerCards.add(PlayerTemplate(
        playerName: "Playername",
        isLeft: false,
      ));
    }

    return playerCards;
  }

// holding trump card if apps works properly
  Widget playedTrickCard() {
    return Container(
      width: 80.0,
      height: 40.0,
      decoration: BoxDecoration(color: Colors.blueGrey),
      child: Text("TrickCard"),
    );
  }

// Widget that takes the list of container from getPlayerContainerLeft
  Widget leftPart() {
    return Container(
      height: heightDevice,
      width: widthDevice * 2 / 5,
      color: Colors.grey,
      child: Column(children: getPlayerContainerLeft()),
    );
  }

// Widget that takes the list of container from getPlayerContainerRight
  Widget rightPart() {
    return Container(
      height: heightDevice,
      width: widthDevice * 2 / 5,
      color: Colors.grey,
      child: Column(children: getPlayerContainerRight()),
    );
  }
}

//for the trump, still need to extend this for the 6th player
class MidPart extends StatefulWidget {
  @override
  _MidPartState createState() => _MidPartState();
}

class _MidPartState extends State<MidPart> {
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

//this is for the user able to see his cards and play from here
class BottomPart extends StatelessWidget {
  final String cardID = "";
  List<PlayingCard> cardList = [
    PlayingCard('2diamonds'),
    PlayingCard('3diamonds'),
    PlayingCard('5spades'),
    PlayingCard('10hearts'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 3 / 10 - 25.0,
      child: Column(
        children: <Widget>[
          CardDropField(cardID),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: cardList),
          Text("Playername")
        ],
      ),
    );
  }
}

//should get trickcard
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
//creates a face up card

//creates face down card
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
