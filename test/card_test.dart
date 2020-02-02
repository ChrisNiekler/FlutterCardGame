import 'package:wizard/logic/cardType.dart';
import 'package:wizard/logic/gamecard.dart';
import 'package:test/test.dart';

//todo import the test package and implement the tests
// https://flutter.dev/docs/cookbook/testing/unit/introduction
void main() {
  group('ALL:', () {
    group('Card:', () {
      /*
      This test will check if a card is created.
       */
      test('Card is created', () {
        GameCard card = new GameCard(CardType.WIZARD, 14);
        expect(card, isNotNull);
      });

      /*
      This test will check if a wizard is created correctly.
       */
      test('Card is Wizard', () {
        GameCard card = new GameCard(CardType.WIZARD, 14);
        expect(card.typeToString(), 'WIZARD');
        expect(card.value, 14);
      });

      /*
      This test will check if a card from type heart with the value 13 is
      created correctly.
       */
      test('Card is Heart', () {
        GameCard card = new GameCard(CardType.HEART, 13);
        expect(card.typeToString(), 'HEART');
        expect(card.value, 13);
      });

      /*
      This test will check if a card from type diamond with the value 1 is
      created correctly.
       */
      test('Card is Diamond', () {
        GameCard card = new GameCard(CardType.DIAMOND, 1);
        expect(card.typeToString(), 'DIAMOND');
        expect(card.value, 1);
      });

      /*
      This test will check if a jester is created correctly.
       */
      test('Card is Jester', () {
        GameCard card = new GameCard(CardType.JESTER, 0);
        expect(card.typeToString(), 'JESTER');
        expect(card.value, 0);
      });

      /*
      This test will check if a card from type club with the value 8 is
      created correctly.
       */
      test('Card is Club', () {
        GameCard card = new GameCard(CardType.CLUB, 8);
        expect(card.typeToString(), 'CLUB');
        expect(card.value, 8);
      });

      /*
      The following three tests will check if the method toString() in
      the dart file gamecard works correctly.
       */
      group('toString test', () {
        test('Club 8', () {
          GameCard card = new GameCard(CardType.CLUB, 8);
          expect(card.toString(), '8clubs');
        });
        test('WIZARD', () {
          GameCard card =
              new GameCard(CardType.WIZARD, 14, passiveType: CardType.HEART);
          expect(card.toString(), '14hearts');
        });
        test('JESTER', () {
          GameCard card =
              new GameCard(CardType.JESTER, 0, passiveType: CardType.CLUB);
          expect(card.toString(), '0clubs');
        });
      });
    }); // end of group Card

    /*
    The following seven tests will check if the method compare(GameCard foe,
     CardType trump) from the file gamecard.dart works correctly.
     */
    group('Compare', () {
      test('noTrump vs noTrump', () {
        // compare same Value noTrump vs trump
        CardType trump = CardType.HEART;
        GameCard clubFive = new GameCard(CardType.CLUB, 5);
        GameCard clubSix = new GameCard(CardType.CLUB, 6);
        expect(clubFive.compare(clubSix, trump), clubSix);
      });

      test('Trump vs Trump', () {
        // compare same Value noTrump vs trump
        CardType trump = CardType.CLUB;
        GameCard clubFive = new GameCard(CardType.CLUB, 5);
        GameCard clubSix = new GameCard(CardType.CLUB, 6);
        expect(clubFive.compare(clubSix, trump), clubSix);
      });

      test('noTrump vs trump same value', () {
        // compare same Value noTrump vs trump
        CardType trump = CardType.HEART;
        GameCard clubFive = new GameCard(CardType.CLUB, 5);
        GameCard heartFive = new GameCard(CardType.HEART, 5);
        expect(clubFive.compare(heartFive, trump), heartFive);
      });

      test('noTrump vs trump different value', () {
        // compare same Value noTrump vs trump
        CardType trump = CardType.HEART;
        GameCard clubThirteen = new GameCard(CardType.CLUB, 13);
        GameCard heartOne = new GameCard(CardType.HEART, 1);
        expect(clubThirteen.compare(heartOne, trump), heartOne);
      });

      test('trump vs wizard', () {
        CardType trump = CardType.HEART;
        GameCard heartThirteen = new GameCard(CardType.HEART, 13);
        GameCard wizard = new GameCard(CardType.WIZARD, 14);
        expect(heartThirteen.compare(wizard, trump), wizard);
      });
      test('wizard vs wizard', () {
        CardType trump = CardType.HEART;
        GameCard wizardFirst =
            new GameCard(CardType.WIZARD, 14, passiveType: CardType.CLUB);
        GameCard wizardSecond =
            new GameCard(CardType.WIZARD, 14, passiveType: CardType.HEART);
        expect(wizardSecond.compare(wizardFirst, trump), wizardFirst);
      });

      test('jester vs jester', () {
        CardType trump = CardType.HEART;
        GameCard jesterFirst =
            new GameCard(CardType.JESTER, 0, passiveType: CardType.CLUB);
        GameCard jesterSecond =
            new GameCard(CardType.JESTER, 0, passiveType: CardType.HEART);
        expect(jesterSecond.compare(jesterFirst, trump), jesterFirst);
      });
    }); // end of group Compare
  }); // end of group ALL
}
