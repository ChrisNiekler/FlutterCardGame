import 'dart:math';

import 'package:wizard2/card.dart';
import 'package:wizard2/deck.dart';
import 'package:wizard2/round.dart';

abstract class Player {
  String name;
  int id;
  List<Card> handCards = [];
  List<Card> playableHandCards = [];
  int bet;
  bool ai;
  void putBet(int bet) {}

  Card playCard(int pick);

  void addCard(Deck deck) {
    handCards.add(deck.takeCard());
  }

  void printHandCardsToConsole() {
    this.handCards.forEach(
      (element) {
        if (element.allowedToPlay) {
          print(element.card);
        }
      },
    );
  }

  void creatingPlayableHandCardsList (){
    this.handCards.forEach(
        (element) {
          if(element.allowedToPlay){
            playableHandCards.add(element);
          }
        }
    );
  }
}
