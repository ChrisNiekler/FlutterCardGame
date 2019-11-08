import 'dart:math';

import 'package:wizard2/card.dart';
import 'package:wizard2/cardTypes.dart';
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

  Card playCard(int pick, {cardTypes trump, Card foe});

//  //done wie kann ich diese methode in round ansprechen, ohne sie auch in humanPlayer implementieren zu müssen???
  //not necessary anymore
//  Card playCardAI(Card foe, Card trump);

  void addCard(Deck deck) {
    handCards.add(deck.takeCard());
  }

  void printHandCardsToConsole() {
    String temp;
    int index = 0;
    this.handCards.forEach(
      (element) {
        temp = element.card;

        if (element.allowedToPlay) {
          print('[$index][+] ' + temp);
        } else {
          print('[$index][-]' + temp);
        }
        index++;
      },
    );
  }

  void creatingPlayableHandCardsList() {
    this.handCards.forEach((element) {
      if (element.allowedToPlay) {
        playableHandCards.add(element);
      }
    });
  }

  cardTypes pickTrumpCard() {
    cardTypes trumpType;
    String type;
    // todo implement this or just override it
    // ask the player who deals to pick the card
    trumpType = cardTypes.values[Random().nextInt(4)];
    type =
        trumpType.toString().substring(trumpType.toString().indexOf('.') + 1);
    print('$name pickt $type (yet random)');
    return trumpType;
  }
}
