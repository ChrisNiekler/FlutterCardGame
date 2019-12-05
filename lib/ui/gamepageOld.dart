import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wizard/ui/trump_MidTable.dart';
import 'package:wizard/ui/playerTemplateGUI.dart';
import 'package:wizard/ui/player_BottomTable.dart';
import 'package:wizard/ui/player_TopTable.dart';
import 'package:wizard/logic/artificial_intelligence/ai.dart';
import 'package:wizard/logic/deck.dart';

class Gamepage extends StatelessWidget {
  Gamepage({this.amountPlayers, this.username});

  int amountPlayers;
  final String username;
  double widthDevice;
  double heightDevice;
  Deck deck;
  @override
  Widget build(BuildContext context) {
    widthDevice = MediaQuery.of(context).size.width;
    heightDevice = MediaQuery.of(context).size.height * 6 / 10;
    return new Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                amountPlayers == 6
                    ? Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[TopPart()],
                        ))
                    : Container(),
                Expanded(
                  flex: 6,
                  child: Row(
                    //mainAxisSize: MainAxisSize.max,
                    children: getTableUI(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: <Widget>[
                      BottomPart(),
                    ],
                  ),
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
        playerName: "Dos",
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
    if (amountPlayers >= 5) {
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
      //  height: heightDevice,
      width: widthDevice * 2 / 5,
      color: Colors.grey,
      child: Column(children: getPlayerContainerLeft()),
    );
  }

// Widget that takes the list of container from getPlayerContainerRight
  Widget rightPart() {
    return Container(
      // height: heightDevice,
      width: widthDevice * 2 / 5,
      color: Colors.grey,
      child: Column(children: getPlayerContainerRight()),
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
            width: 15.0,
          ),
        ));
  }
}
