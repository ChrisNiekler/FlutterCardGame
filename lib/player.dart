import 'package:wizard2/card.dart';

class Player {
  String name;
  int id; // why should it be a String?
  List<Card> handCards;
  int bet;
  void putBet(int bet) {}
  void playCard(Card card) {}

  Player(this.name, this.id);
}
