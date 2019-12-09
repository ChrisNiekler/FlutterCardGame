import 'package:wizard/logic/player.dart';
import 'package:wizard/logic/card.dart' as logic;
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

  logic.Card playCardAI(logic.Card foe, CardType Trump) {
    int pick = Random().nextInt(playableHandCards.length);
    return handCards.removeAt(pick);
  }

  logic.Card findCard() {
    int temp = Random().nextInt(playableHandCards.length);
    logic.Card findCard = playableHandCards[temp];
    return findCard;
  }

  @override
  logic.Card playCard(int pick,
      {CardType trump,
      logic.Card foe,
      int roundNumber,
      int playerNumber,
      List<logic.Card> alreadyPlayedCards,
      List<logic.Card> playedCards,
      logic.Card highestCard}) {
    if (trump == null) {
      logic.Card temp = findCard();
      handCards.remove(temp);
      return temp;
    } else if (foe == null) {
      pick = Random().nextInt(playableHandCards.length);
      return handCards.removeAt(pick);
    } else {
      return playCardAI(foe, trump);
    }
  }

  @override
  void putBet(int round, int betsNumber,
      {CardType trump,
      String testValue,
      List<logic.Card> alreadyPlayedCards,
      List<logic.Card> playedCards,
      int playerNumber,
      bool firstPlayer}) {
    this.bet = Random().nextInt(handCards.length);
    print('$name bet he/she wins $bet tricks!');
  }

  @override
  Future<logic.Card> playCardFuture() {
    // TODO: implement playCardFuture
    return null;
  }
}
