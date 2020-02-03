import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wizard/logic/gamecard.dart' as logic;
import 'package:wizard/logic/deck.dart';
import 'package:wizard/logic/player.dart';

/*
Todo add description
TOdo Is this still needed?????
 */
// todo how to implement widgets other then in the main
class showingCard extends StatefulWidget {
  showingCard(this.tcard, this.roundNumber, this.maxRound, this.players,
      this.deck, this.trumpCard);
  logic.GameCard tcard;
  int roundNumber;
  int maxRound;
  List<Player> players;
  Deck deck;
  logic.GameCard trumpCard;
  logic.GameCard tableCard;

  @override
  _showingCardState createState() => _showingCardState();
}

class _showingCardState extends State<showingCard> {
  void cardDistribution() {
    int lng = widget.players.length;
    for (int i = 0; i < widget.roundNumber; i++) {
      for (int j = 0; j < lng; j++) {
        widget.players[j].handCards.add(widget.deck.takeCard());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          print(widget.tcard.toString());
          setState(() {
            // FIX: condition
            if (widget.players[5].handCards.length == 1 &&
                widget.roundNumber < widget.maxRound) {
              print("Next round will be initialized");
              widget.roundNumber++;
              widget.deck = new Deck();
              cardDistribution();
              if (widget.deck.size() != 0) {
                widget.trumpCard = widget.deck.takeCard();
              } else {
                widget.trumpCard = null;
              }
            }
            widget.tableCard = widget.tcard;
            widget.players[0].handCards.remove(widget.tcard);
          });
        },
        child: widget.tcard.playerCardsWidget(),
      ),
    );
  }
}
