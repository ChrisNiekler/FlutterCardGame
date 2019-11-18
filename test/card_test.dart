import 'package:wizard/cardType.dart';
import 'package:wizard/card.dart';
import 'package:test/test.dart';

//todo import the test package and implement the tests
// https://flutter.dev/docs/cookbook/testing/unit/introduction
void main() {
  group('ALL:', () {
    group('Card:', () {
      test('Card is created', () {
        Card card = new Card(CardType.WIZARD, 14);
        expect(card, isNotNull);
      });

      test('Card is Wizard', () {
        Card card = new Card(CardType.WIZARD, 14);
        expect(card.typeToString(), 'WIZARD');
        expect(card.value, 14);
      });

      test('Card is Heart', () {
        Card card = new Card(CardType.HEART, 13);
        expect(card.typeToString(), 'HEART');
        expect(card.value, 13);
      });

      test('Card is Diamond', () {
        Card card = new Card(CardType.DIAMOND, 1);
        expect(card.typeToString(), 'DIAMOND');
        expect(card.value, 1);
      });

      test('Card is Jester', () {
        Card card = new Card(CardType.JESTER, 0);
        expect(card.typeToString(), 'JESTER');
        expect(card.value, 0);
      });

      test('Card is Club', () {
        Card card = new Card(CardType.CLUB, 8);
        expect(card.typeToString(), 'CLUB');
        expect(card.value, 8);
      });
      group('toString test', () {
        test('Club 8', () {
          Card card = new Card(CardType.CLUB, 8);
          expect(card.toString(), '8clubs');
        });
        test('WIZARD', () {
          Card card =
              new Card(CardType.WIZARD, 14, passiveType: CardType.HEART);
          expect(card.toString(), '14hearts');
        });
        test('JESTER', () {
          Card card = new Card(CardType.JESTER, 0, passiveType: CardType.CLUB);
          expect(card.toString(), '0clubs');
        });
      });
    }); // end of group Card

    group('Compare', () {
      test('noTrump vs noTrump', () {
        // compare same Value noTrump vs trump
        CardType trump = CardType.HEART;
        Card clubFive = new Card(CardType.CLUB, 5);
        Card clubSix = new Card(CardType.CLUB, 6);
        expect(clubFive.compare(clubSix, trump), clubSix);
      });

      test('Trump vs Trump', () {
        // compare same Value noTrump vs trump
        CardType trump = CardType.CLUB;
        Card clubFive = new Card(CardType.CLUB, 5);
        Card clubSix = new Card(CardType.CLUB, 6);
        expect(clubFive.compare(clubSix, trump), clubSix);
      });

      test('noTrump vs trump same value', () {
        // compare same Value noTrump vs trump
        CardType trump = CardType.HEART;
        Card clubFive = new Card(CardType.CLUB, 5);
        Card heartFive = new Card(CardType.HEART, 5);
        expect(clubFive.compare(heartFive, trump), heartFive);
      });

      test('noTrump vs trump different value', () {
        // compare same Value noTrump vs trump
        CardType trump = CardType.HEART;
        Card clubThirteen = new Card(CardType.CLUB, 13);
        Card heartOne = new Card(CardType.HEART, 1);
        expect(clubThirteen.compare(heartOne, trump), heartOne);
      });

      test('trump vs wizard', () {
        CardType trump = CardType.HEART;
        Card heartThirteen = new Card(CardType.HEART, 13);
        Card wizard = new Card(CardType.WIZARD, 14);
        expect(heartThirteen.compare(wizard, trump), wizard);
      });
      test('wizard vs wizard', () {
        CardType trump = CardType.HEART;
        Card wizardFirst = new Card(CardType.WIZARD, 14);
        Card wizardSecond = new Card(CardType.WIZARD, 14);
        expect(wizardSecond.compare(wizardFirst, trump), wizardFirst);
      });

      test('jester vs jester', () {
        CardType trump = CardType.HEART;
        Card jesterFirst = new Card(CardType.JESTER, 0);
        Card jesterSecond = new Card(CardType.JESTER, 0);
        expect(jesterSecond.compare(jesterFirst, trump), jesterFirst);
      });
    }); // end of group Compare
  }); // end of group ALL
}
