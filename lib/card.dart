import 'package:wizard/cardType.dart';

class Card {
  CardType cardType;
  int value;
  String card;
  bool allowedToPlay = false;
  // clubs (♣), diamonds (♦), hearts (♥) and spades (♠)

  String typeToString() {
    return CardTypeHelper.getValue(cardType);
  }

  Card(this.cardType, this.value) {
    String icon = '';
    this.card = this.typeToString();

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
    if (this.cardType != CardType.JESTER && this.cardType != CardType.WIZARD) {
      this.card += value.toString();
    }
  }
  Card compare(Card foe, CardType trump) {
    if (foe.value == 14)
      return foe;
    else if (this.value == 14)
      return this;
    else if (foe.value == 0 && this.value != 0)
      return this;
    else if (this.cardType == trump && foe.cardType != trump)
      return this;
    else if (this.cardType == foe.cardType && this.value > foe.value)
      return this;
    else
      return foe;
  }
}
