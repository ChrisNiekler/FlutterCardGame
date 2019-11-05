import 'package:wizard2/card.dart';
import 'package:wizard2/player.dart';

class HumanPlayer extends Player {
  @override
  Card playCard(int pick) {
    Card temp = this.handCards[pick];
    handCards.removeAt(pick);
    return temp;
  }

  HumanPlayer(name, id) {
    this.ai = false;
    this.name = name;
    this.id = id;
  }
}
