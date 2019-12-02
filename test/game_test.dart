import 'package:test/test.dart';
import 'package:wizard/logic/card.dart';
import 'package:wizard/logic/cardType.dart';

void main() {
  group('Card:', () {
    test('Card is created', () {
      Card card = new Card(CardType.WIZARD, 14);
      expect(card, isNotNull);
    });
    test('Card has expected name', () {
      Card card = new Card(CardType.WIZARD, 14);
      expect(card.card, 'WIZARD  (🧙)');
    });
  });
}
