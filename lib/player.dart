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

  //todo wie kann ich diese methode in round ansprechen, ohne sie auch in humanPlayer implementieren zu müssen???
  Card playCardAI(Card foe, Card trump);

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
}
