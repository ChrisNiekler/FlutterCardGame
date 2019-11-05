import 'package:wizard2/card.dart';
import 'package:wizard2/deck.dart';
import 'package:wizard2/cardTypes.dart';

class Player {
  String name;
  int id; // why should it be a String?
  List<Card> handCards = [];
  int bet;
  void putBet(int bet) {}
  void playCard(Card card) {}

  void addCard(Deck deck) {
    handCards.add(deck.takeCard());
  }

  // for testing only
  void printHandCardsToConsole() {
    this.handCards.forEach((element) => print(element.card));
  }

  Player(this.name, this.id);
}
