import 'package:wizard/logic/player.dart';
import 'package:wizard/logic/gamecard.dart' as logic;
import '../cardType.dart';
import 'dart:math' show Random;

//todo Tests für AI

class Ai extends Player {
  //Klasse Ai erbt von Klasse Player//
  Ai(name, id) {
    this.name = name; //name übernehmen//
    this.id = id; //id übernehmen//
    this.ai = true; //ai auf true setzen//
  }

  @override
  CardType pickTrumpCard({String testValue}) {
    CardType trumpType;
    String type;

    trumpType = CardType.values[Random().nextInt(4)];
    type =
        trumpType.toString().substring(trumpType.toString().indexOf('.') + 1);
    print('$name pickt $type (yet random)');
    return trumpType;
  }

  logic.GameCard playCardAI(logic.GameCard foe, CardType Trump) {
    int pick = Random().nextInt(playableHandCards.length);
    return handCards[pick];
//    return handCards.removeAt(pick);
  }

  logic.GameCard findCard() {
    int temp = Random().nextInt(playableHandCards.length);
    logic.GameCard findCard = playableHandCards[temp];
    return findCard;
  }

  @override
  logic.GameCard playCard(int pick,
      {CardType trump,
      logic.GameCard foe,
      int roundNumber,
      int playerNumber,
      List<logic.GameCard> alreadyPlayedCards,
      List<logic.GameCard> playedCards,
      logic.GameCard highestCard}) {
    if (trump == null) {
      logic.GameCard temp = findCard();
//      handCards.remove(temp);
      return temp;
    } else if (foe == null) {
      pick = Random().nextInt(playableHandCards.length);
      return handCards[pick];
//      return handCards.removeAt(pick);
    } else {
      return playCardAI(foe, trump);
    }
  }

  @override
  void putBet(int round, int betsNumber,
      {CardType trump,
      String testValue,
      List<logic.GameCard> alreadyPlayedCards,
      List<logic.GameCard> playedCards,
      int playerNumber,
      bool firstPlayer}) {
    this.bet = Random().nextInt(handCards.length);
    print('$name bet he/she wins $bet tricks!');
  }

  @override
  Future<logic.GameCard> playCardFuture() {
    // TODO: implement playCardFuture
    return null;
  }
}
