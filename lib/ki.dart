import 'dart:io';

import 'package:wizard2/player.dart';
import 'package:wizard2/card.dart';
import 'package:wizard2/deck.dart';
import 'package:wizard2/cardTypes.dart';
import 'dart:math' show Random;
import 'package:wizard2/round.dart';

class Ki extends Player {
  @override
  Card playCard(int pick) {
    var rndm = new Random();


    //here between all handcards is chosen
    //var numpick = rndm.nextInt(pick);
    ////print(numpick);   //Test if it's random
    //Card temp = this.handCards[numpick]; //used for play random card
    //handCards.removeAt(numpick);

    this.creatingPlayableHandCardsList();
    var numpick = rndm.nextInt(playableHandCards.length);
    Card temp = this.playableHandCards[numpick]; //used for play random card
    handCards.remove(this.playableHandCards[numpick]);

    //Card temp = this.handCards[0];      //used for play first card
    //handCards.removeAt(0);
    return temp;
  }

  Ki(name, id) {
    this.ai = true;
    this.name = name;
    this.id = id;
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
    //return 0;
  }
  //wetten
  //todo erste bet erstmal immer 1
  //todo zweite bet alle Karten größer gleich 10 ist Anzahl der bet -> wenn nicht möglich zu legen auf Grund der Logik, dann eine weniger wetten
  //todo Wahrscheinlichkeitsberechnung für bessere Karten, als alle Anderen
  //todo an Hand der Wahrscheinlichkeit die dritte bet

  //todo Tests für KI

  void findBestCard() {
    //find algorithm for finding best card of the Hand  (and worst)
    //then only if trick can be made
  }
}
