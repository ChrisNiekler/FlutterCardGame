import 'package:wizard2/card.dart';
import 'package:wizard2/deck.dart';

abstract class Player {
  String name;
  int id;
  List<Card> handCards = [];
  int bet;
  void putBet(int bet) {}

  Card playCard(int pick);

  void addCard(Deck deck) {
    handCards.add(deck.takeCard());
  }
}
