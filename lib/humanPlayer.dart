import 'package:wizard2/card.dart';
import 'package:wizard2/player.dart';
import 'cardTypes.dart';

class HumanPlayer extends Player {
  @override
  Card playCard(int pick, {cardTypes trump, Card foe}) {
    Card temp = this.handCards[pick];
    handCards.removeAt(pick);
    return temp;
  }

//  //done fix it and make it work without this underneath
  //not necessary anymore
//  @override
//  Card playCardAI(Card foe, Card trump){
//    return foe;
//  }

  HumanPlayer(name, id) {
    this.ai = false;
    this.name = name;
    this.id = id;
  }
}
