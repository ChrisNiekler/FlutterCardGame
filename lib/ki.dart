import 'dart:io';

import 'package:wizard2/player.dart';
import 'package:wizard2/card.dart';
import 'package:wizard2/deck.dart';
import 'package:wizard2/cardTypes.dart';

class Ki extends Player {
  @override
  Card playCard(int pick) {
    Card temp = this.handCards[0];
    handCards.removeAt(0);
    return temp;
  }

  Ki(name, id) {
    this.ai = true;
    this.name = name;
    this.id = id;
  }

  //karte legen
  //todo erste KI mit random oder erster Kart
  //todo zweite KI mit erster legbarer Karte
  //todo dritte KI mit bester legbarer Karte
  //todo Wahrscheinlichkeitsberechnung für Gewinn des Stichs
  //todo vierte KI beste legbare Karte, wenn Wahrscheinlichkeit für Stich größer 0,75
  //todo fünfte KI beste legbare Karte, wenn hohe Wahrscheinlichkeit für Stich und auch überhaupt noch ein Stich benötigt
  //hohe Wahrscheinlichkeit: abhängig von noch vorhanden Karten, der anderen Spieler

  //wetten
  //todo erste bet erstmal immer 1
  //todo zweite bet alle Karten größer gleich 10 ist Anzahl der bet -> wenn nicht möglich zu legen auf Grund der Logik, dann eine weniger wetten
  //todo Wahrscheinlichkeitsberechnung für bessere Karten, als alle Anderen
  //todo an Hand der Wahrscheinlichkeit die dritte bet

  //todo Tests für KI

}
