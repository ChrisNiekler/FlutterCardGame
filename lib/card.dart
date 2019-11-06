import 'package:wizard2/cardTypes.dart';

class Card {
  cardTypes cardType;
  int value;
  String card;
  bool allowedToPlay = false;
  // clubs (♣), diamonds (♦), hearts (♥) and spades (♠)
  Card(this.cardType, this.value) {
    String icon = '';
    this.card =
        cardType.toString().substring(cardType.toString().indexOf('.') + 1);
    if (this.card == 'SPADE') {
      icon = '   (♠)';
    } else if (this.card == 'CLUB') {
      icon = '    (♣)';
    } else if (this.card == 'HEART') {
      icon = '   (♥)';
    } else if (this.card == 'DIAMOND') {
      icon = ' (♦)';
    } else if (this.card == 'WIZARD') {
      icon = '  (🧙)';
    } else if (this.card == 'JESTER') {
      icon = '  (🤡)';
    }
    this.card += icon;
    if (this.cardType != cardTypes.JESTER &&
        this.cardType != cardTypes.WIZARD) {
      this.card += value.toString();
    }
  }
  Card compare(Card foe, Card trump) {
    if(foe.value == 14) return foe;
    else if (this.cardType == trump.cardType && foe.cardType != trump.cardType) return this;
    else if(this.cardType == foe.cardType){
      if(this.value > foe.value) return this;
      else return foe;
    }
    else return foe;
  }
}