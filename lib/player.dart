import 'package:wizard2/card.dart';
import 'package:wizard2/deck.dart';
import 'package:wizard2/cardTypes.dart';

class Player {
  String name;
  int id; // why should it be a String?
  List<Card> handCards = [];
  int bet;
  void putBet(int bet) {}

  // takes an int value and returns the card with that index
  Card playCard(int pick) {
    Card temp = this.handCards[pick];
    handCards.removeAt(pick);
    return temp;
  }

  void addCard(Deck deck) {
    handCards.add(deck.takeCard());
  }

  // for testing only
  void printHandCardsToConsole() {
    this.handCards.forEach((element) => print(element.card));
  }

  Player(this.name, this.id);
}
