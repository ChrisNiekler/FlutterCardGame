import 'dart:io';

import 'package:wizard2/player.dart';
import 'package:wizard2/card.dart';
import 'package:wizard2/deck.dart';
import 'package:wizard2/cardTypes.dart';
import 'dart:math' show Random;
import 'package:wizard2/round.dart';

class Ki extends Player {

  Ki(name, id) {
    this.ai = true;
    this.name = name;
    this.id = id;
  }


  @override
  Card playCard(int pick) {
    //this.creatingPlayableHandCardsList();
    // habs rausgenommen weil ich creatingPlayableHandCards für alle Player
    // in playCards() aufrufe --> mfg Chris
    // ps Delete this message

    var rndm = new Random();

    //1. here it is chosen between all handcards
    //var numpick = rndm.nextInt(pick);
    ////print(numpick);   //Test if it's random
    //Card temp = this.handCards[numpick]; //used for play random card
    //handCards.removeAt(numpick);

    //2. here it is chosen between all playable handcards
    var numpick = rndm.nextInt(playableHandCards.length);
    Card temp = this.playableHandCards[numpick]; //used for play random card
    handCards.remove(playableHandCards[numpick]);

    //0. lege erste Karte vom Hand
    //Card temp = this.handCards[0];      //used for play first card
    //handCards.removeAt(0);
    return temp;
  }

  @override
  Card playCardAI(Card foe, Card trump) {
    //3. here play best or worst Card -> at the  moment problem caching value of the best played card and the trump
    //todo value of best playedcard in round
    Card bestCard = findBestCard();
    Card worstCard = findWorstCard();
//    Card tump = Round.giveTrumpCard();
//    Card nowbest = bestPlayedCardYet();
    if(bestCard == bestCard.compare(foe, trump) ){
      Card temp = bestCard;
      handCards.remove(playableHandCards[findIndexBestCard()]);
      return temp;
    }
    else{
      Card temp = worstCard;
      handCards.remove(playableHandCards[findIndexWorstCard()]);
      return temp;
    }
  }


  //karte legen
  //both done erste KI mit random oder erster Kart
  //done zweite KI mit erster (oder random) legbarer Karte
  //todo dritte KI mit bester legbarer Karte
  //todo Wahrscheinlichkeitsberechnung für Gewinn des Stichs
  //todo vierte KI beste legbare Kartodote, wenn Wahrscheinlichkeit für Stich größer 0,75
  //todo fünfte KI beste legbare Karte, wenn hohe Wahrscheinlichkeit für Stich und auch überhaupt noch ein Stich benötigt
  //hohe Wahrscheinlichkeit: abhängig von noch vorhanden Karten, der anderen Spieler

  void putBet(int bet) {
    //return 1;
  }
  //wetten
  //todo erste bet erstmal immer 1
  //todo zweite bet alle Karten größer gleich 10 ist Anzahl der bet -> wenn nicht möglich zu legen auf Grund der Logik, dann eine weniger wetten
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
    Card bestCard = this.playableHandCards[0];
    int x = 0;
    for (int i = 1; i < playableHandCards.length; i++) {
      if (bestCard.value > playableHandCards[i].value)
        x = i;
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
    Card worstCard = this.playableHandCards[0];
    int x = 0;
    for (int i = 1; i < playableHandCards.length; i++) {
      if (worstCard.value > playableHandCards[i].value)
        x = i;
    }
    return x;
  }
}
