import 'package:wizard2/cardType.dart';
import 'package:wizard2/card.dart';
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

// todo implement a test for testing the card distribution
//// prints out all the cards of all the players to the console
//players.forEach((element) {
//String n = element.name;
//print('Playername: $n');
//print('Cards in hand!');
//element.printHandCardsToConsole();
//print('\n');
//});
//// print the current trump card
//print('The trump is: ');
//print(this.trump.card);
//}

/* Test ob Compare() funktioniert
  *Card playedCard = new Card(cardTypes.DIAMOND, 3);
  *Card highestCard = new Card(cardTypes.DIAMOND, 10);
  *Card trumpCard = new Card(cardTypes.DIAMOND, 3);
  *Card ergebnisCard = playedCard.compare(highestCard, trumpCard);
  *print(ergebnisCard.card );
  * */
