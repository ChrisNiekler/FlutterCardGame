enum CardType {
  CLUB,
  DIAMOND,
  HEART,
  SPADE,
  JESTER,
  WIZARD
  // clubs (♣), diamonds (♦), hearts (♥) and spades (♠)

}

class CardTypeHelper {
  static String getValue(CardType cardType) {
    switch (cardType) {
      case CardType.CLUB:
        return 'CLUB';
      case CardType.DIAMOND:
        return 'DIAMOND';
      case CardType.HEART:
        return 'HEART';
      case CardType.SPADE:
        return 'SPADE';
      case CardType.JESTER:
        return 'JESTER';
      case CardType.WIZARD:
        return 'WIZARD';
      default:
        return "";
    }
  }
}
//todo implement toString
// this.toString().indexOf('.') + 1
