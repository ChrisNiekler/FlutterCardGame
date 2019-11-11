import 'package:wizard2/player.dart';
import 'package:wizard2/card.dart';
import 'package:wizard2/cardTypes.dart';
import 'dart:math' show Random;

class Ki extends Player {
  Ki(name, id) {
    this.ai = true;
    this.name = name;
    this.id = id;
  }

  @override
  Card playCard(int pick, {cardTypes trump, Card foe}) {
    //1. here it is chosen between all handcards
    if (trump == null) {
      Card temp = findBestCard();
      handCards.remove(temp);
      return temp;
    } else if (foe == null) {
      //todo if no card is played yet (improve this)
      //2. here it is chosen between all playable handcards
      pick = Random().nextInt(playableHandCards.length);
      //Card temp = this.playableHandCards[numpick]; //used for play random card
      return handCards.removeAt(pick);
    } else {
      return playCardAI(foe, trump);
    }

    //return temp;
  }

// @override
  Card playCardAI(Card foe, cardTypes trump) {
    //3. here play best or worst Card -> at the  moment problem caching value of the best played card and the trump
    //todo value of best playedcard in round F4N
    Card bestCard = findBestCard();
    Card worstCard = findWorstCard();
//    Card tump = Round.giveTrumpCard();
//    Card nowbest = bestPlayedCardYet();
    if (bestCard == bestCard.compare(foe, trump) && tricks < bet) {
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
  //todo done erste KI mit random oder erster Kart F4N
  //todo zweite KI mit erster (oder random) legbarer Karte F4N
  //todo dritte KI mit bester legbarer Karte
  //todo Wahrscheinlichkeitsberechnung für Gewinn des Stichs
  //todo vierte KI beste legbare Kartodote, wenn Wahrscheinlichkeit für Stich größer 0,75
  //todo fünfte KI beste legbare Karte, wenn hohe Wahrscheinlichkeit für Stich und auch überhaupt noch ein Stich benötigt
  //hohe Wahrscheinlichkeit: abhängig von noch vorhanden Karten, der anderen Spieler

  @override
  void putBet(int round, int betsNumber, bool lastPlayer, {cardTypes trump}) {
    int check;
    this.bet = 0;
    for (int i = 0; i < handCards.length; i++) {
      if (handCards[i].cardType == trump && handCards[i].value > 8)
        bet++;
      else if (handCards[i].value > 11) bet++;
    }
    check = bet + betsNumber;
    //todo cannot bet more than the possible handcards F4N
    if (lastPlayer && check == round) bet--;
    print('$name bet he/she wins $bet tricks!');
  }

  @override
  int getBetsNumber() {
    return bet;
  }

  //wetten
  //todo erste bet erstmal immer 1 F4N
  //todo zweite bet alle Karten größer gleich 10 ist Anzahl der bet F4N -> wenn nicht möglich zu legen auf Grund der Logik, dann eine weniger wetten
  //todo Wahrscheinlichkeitsberechnung für bessere Karten, als alle Anderen
  //todo an Hand der Wahrscheinlichkeit die dritte bet

  //todo Tests für KI

  Card findBestCard() {
    //find algorithm for finding best card of the Hand  (and worst)
    //then only if trick can be made
    Card bestCard = this.playableHandCards[0];
    for (int i = 1; i < playableHandCards.length; i++) {
      if (bestCard.value < playableHandCards[i].value)
        bestCard = playableHandCards[i];
    }
    return bestCard;
    //todo next step compare() auf eigene Handkarten (trump and highest card needed)
    //for(int i = 0; i < playableHandCards.length; i++) {
    //  playableHandCards.compareHandCards(foe, turmp)
  }

  int findIndexBestCard() {
    //no usage
    Card bestCard = this.playableHandCards[0];
    int x = 0;
    for (int i = 1; i < playableHandCards.length; i++) {
      if (bestCard.value < playableHandCards[i].value) x = i;
    }
    return x;
  }

  Card findWorstCard() {
    Card worstCard = this.playableHandCards[0];
    for (int i = 1; i < playableHandCards.length; i++) {
      if (worstCard.value > playableHandCards[i].value)
        worstCard = playableHandCards[i];
    }
    return worstCard;
  }

  int findIndexWorstCard() {
    //no usage
    Card worstCard = this.playableHandCards[0];
    int x = 0;
    for (int i = 1; i < playableHandCards.length; i++) {
      if (worstCard.value > playableHandCards[i].value) x = i;
    }
    return x;
  }

//todo if wizard is played (pick trump)
}
