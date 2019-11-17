import 'package:wizard/player.dart';
import 'package:wizard/card.dart';
import 'cardType.dart';
import 'dart:math' show Random;

//todo Tests für AI

class Ai extends Player { //Klasse Ai erbt von Klasse Player//
  Ai(name,id){
    this.name = name; //name übernehmen//
    this.id = id; //id übernehmen//
    this.ai = true; //ai auf true setzen//
  }

  Card playCardAI(Card foe, CardType Trump){
    int pick = Random().nextInt(playableHandCards.length);
    return handCards.removeAt(pick);
  }

  Card findCard() {
    int temp = Random().nextInt(playableHandCards.length);
    Card findCard = playableHandCards[temp];
    return findCard;
  }

  @override
  Card playCard(int pick, {CardType trump, Card foe, int roundNumber, int playerNumber, List<Card> alreadyPlayedCards, List<Card> playedCards}){
    if (trump == null){
      Card temp = findCard();
      handCards.remove(temp);
      return temp;
    } else if (foe == null){
      pick = Random().nextInt(playableHandCards.length);
      return handCards.removeAt(pick);
    } else {
      return playCardAI(foe , trump);
    }
  }

  @override
  void putBet(int round, int betsNumber, {CardType trump, String testValue, List<Card> alreadyPlayedCards, List<Card> playedCards}) {
    this.bet = Random().nextInt(handCards.length);
    print('$name bet he/she wins $bet tricks!');
  }

}