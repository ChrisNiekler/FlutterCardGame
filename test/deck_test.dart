import 'package:test/test.dart';
import 'package:wizard/logic/cardType.dart';
import 'package:wizard/logic/deck.dart';

void main() {
  group('ALL:', () {

    /*
    The following test will check if a deck is created.
     */
    group('New Deck:', () {
      Deck testDeck = new Deck();
      test('Size == 60', () {
        expect(testDeck.size(), 60);
      });

      /*
      The following group of tests will check if the right amount of card of
      each type is in the deck after it is created.
       */
      group('deck contains 4 wizards', () {
        int w = 0;
        int j = 0;
        int h = 0;
        int s = 0;
        int d = 0;
        int c = 0;

        testDeck.deck.forEach((crd) {
          if (crd.cardType == CardType.WIZARD) w++;
          if (crd.cardType == CardType.JESTER) j++;
          if (crd.cardType == CardType.HEART) h++;
          if (crd.cardType == CardType.SPADE) s++;
          if (crd.cardType == CardType.DIAMOND) d++;
          if (crd.cardType == CardType.CLUB) c++;
        });
        test('Wizard == 4', () {
          expect(w, 4);
        });
        test('Jester == 4', () {
          expect(j, 4);
        });
        test('Heart == 13', () {
          expect(h, 13);
        });
        test('Spade == 13', () {
          expect(s, 13);
        });
        test('Diamond == 13', () {
          expect(d, 13);
        });
        test('Club == 13', () {
          expect(c, 13);
        });
      });

      /*
      The following test will check if a card is taken from the deck
      with the method takeCard().
       */
      test('draw card', () {
        testDeck.takeCard();
        expect(testDeck.size(), 59);
      });
    }); // end New Deck
  }); // end of ALL
}
