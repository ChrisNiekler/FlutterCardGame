import 'package:wizard/player.dart';
import 'package:wizard/card.dart';
import 'package:wizard/cardType.dart';
import 'dart:math' show Random;

//todo Tests für KI

class KuenstlicheIntelligenz extends Player {
  KuenstlicheIntelligenz(name, id) {
    this.ai = true;
    this.name = name;
    this.id = id;
  }

  @override
  Card playCard(int pick, {CardType trump, Card foe, int roundNumber, int playerNumber}) {
    //1. here it is chosen between all handcards
    if (trump == null) {
      //todo improve (when there is no trump)
      Card temp = findBestCard();
      handCards.remove(temp);
      return temp;
    } else if (foe == null) {
      //todo if no card is played yet (improve this)
      //2. here it is chosen between all playable handcards
      pick = Random().nextInt(playableHandCards.length);
      return handCards.removeAt(pick);
    } else {
      return playCardAI(foe, trump);
    }
  }

  Card playCardAI(Card foe, CardType trump) {
    //3. here play best or worst Card -> at the  moment problem caching value of the best played card and the trump
    //todo get more intelligent (Wahrscheinlichkeiten, ...)
    Card bestCard = findBestCard();
    Card worstCard = findWorstCard();
    if (bestCard == bestCard.compare(foe, trump) &&
        tricks < bet &&
        foe.cardType != CardType.WIZARD) {
      Card temp = bestCard;
      handCards.remove(bestCard);
      return temp;
    } else {
      Card temp = worstCard;
      handCards.remove(worstCard);
      return temp;
    }
  }

  //karte legen
  //todo DONE erste KI mit random oder erster Karte
  //todo DONE zweite KI mit erster (oder random) legbarer Karte
  //todo DONE dritte KI mit bester legbarer Karte

  //todo Wahrscheinlichkeitsberechnung für Gewinn des Stichs
  //todo vierte KI beste legbare Kartodote, wenn Wahrscheinlichkeit für Stich größer 0,75
  //todo fünfte KI beste legbare Karte, wenn hohe Wahrscheinlichkeit für Stich und auch überhaupt noch ein Stich benötigt
  //hohe Wahrscheinlichkeit: abhängig von noch vorhanden Karten, der anderen Spieler

  @override
  void putBet(int round, int betsNumber, {CardType trump, String testValue}) {
    int check;
    this.bet = 0;
    for (int i = 0; i < handCards.length; i++) {
      if (handCards[i].cardType == trump && handCards[i].value > 8)
        bet++;
      else if (handCards[i].value > 11) bet++;
    }
    check = bet + betsNumber;
    if (this.lastPlayer && check == round) {
      if (bet == 0)
        bet++;
      else
        bet--;
    }
    print('$name bet he/she wins $bet tricks!');
  }

  //wetten
  //todo DONE erste bet erstmal immer 1
  //todo DONE zweite bet alle Karten größer gleich 10 ist Anzahl der bet -> wenn nicht möglich zu legen auf Grund der Logik, dann eine weniger wetten

  //todo Wahrscheinlichkeitsberechnung für bessere Karten, als alle Anderen
  //todo an Hand der Wahrscheinlichkeit die dritte bet

  Card findBestCard() {
    //todo maybe check if there is a check with trump and not trump needed
    Card bestCard = this.playableHandCards[0];
    for (int i = 1; i < playableHandCards.length; i++) {
      if (bestCard.value < playableHandCards[i].value)
        bestCard = playableHandCards[i];
    }
    return bestCard;
  }

  Card findWorstCard() {
    //todo maybe check if there is a check with trump and not trump needed
    Card worstCard = this.playableHandCards[0];
    for (int i = 1; i < playableHandCards.length; i++) {
      if (worstCard.value > playableHandCards[i].value)
        worstCard = playableHandCards[i];
    }
    return worstCard;
  }

  int _getWahrscheinlichkeit(int roundNumber, int playerNumber){
    int x = 0;
    final int gesamt = 60;
    int cardsInRound = roundNumber * playerNumber;
    int ownCards = roundNumber;
    for(int i = 0; i < handCards.length; i++){
      //todo wahrscheinlichkeitsrechnung machen
    }
    return x;
  }

//todo if wizard is trump (pick trump)
}
