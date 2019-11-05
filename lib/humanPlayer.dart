import 'package:wizard2/card.dart';
import 'package:wizard2/player.dart';

class HumanPlayer extends Player {
  String name;
  int id;
  List<Card> handCards = [];
  int bet;

  @override
  Card playCard(int pick) {
    Card temp = this.handCards[pick];
    handCards.removeAt(pick);
    return temp;
  }

  HumanPlayer(this.name, this.id);
}
