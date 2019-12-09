import 'package:test/test.dart';
import 'package:wizard/logic/gamecard.dart';
import 'package:wizard/logic/cardType.dart';

void main() {
  group('Card:', () {
    test('Card is created', () {
      GameCard card = new GameCard(CardType.WIZARD, 14);
      expect(card, isNotNull);
    });
    test('Card has expected name', () {
      GameCard card = new GameCard(CardType.WIZARD, 14);
      expect(card.card, 'WIZARD  (🧙)');
    });
  });
}
