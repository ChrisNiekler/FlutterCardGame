import 'package:wizard2/types.dart';

class Card {
  cardTypes cardType;
  int value;
  String card;
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
}

bool compare(Card foe) {
  return true;
}
