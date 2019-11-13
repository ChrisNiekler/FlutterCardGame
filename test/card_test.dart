import 'package:wizard2/cardType.dart';
import 'package:wizard2/card.dart';
import 'package:test/test.dart';

//todo import the test package and implement the tests
// https://flutter.dev/docs/cookbook/testing/unit/introduction
void main() {
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
    test('Card has expected name', () {
      Card card = new Card(CardType.HEART, 13);
      expect(card.typeToString(), 'HEART');
      expect(card.value, 13);
    });
    test('Card has expected name', () {
      Card card = new Card(CardType.DIAMOND, 1);
      expect(card.typeToString(), 'DIAMOND');
      expect(card.value, 1);
    });
    test('Card has expected name', () {
      Card card = new Card(CardType.JESTER, 0);
      expect(card.typeToString(), 'JESTER');
      expect(card.value, 0);
    });
    test('Card has expected name', () {
      Card card = new Card(CardType.CLUB, 8);
      expect(card.typeToString(), 'CLUB');
      expect(card.value, 8);
    });
  });
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
