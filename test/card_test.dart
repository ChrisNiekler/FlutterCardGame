import 'package:wizard2/cardTypes.dart';
import 'package:wizard2/card.dart';
import 'package:test/test.dart';

//todo import the test package and implement the tests
// https://flutter.dev/docs/cookbook/testing/unit/introduction
void main() {
  group('Card:', () {
    test('Card is created', () {
      Card card = new Card(cardTypes.WIZARD, 14);
      expect(card, isNotNull);
    });
    test('Card has expected name', () {
      Card card = new Card(cardTypes.WIZARD, 14);
      expect(card.card, 'WIZARD  (🧙)');
    });
  });
}

//void cardTest() {
//  Card testCard = new Card(cardTypes.SPADE, 4);
//  print(testCard.card);
//  Card testCard2 = new Card(cardTypes.DIAMOND, 5);
//  print(testCard2.card);
//  Card testCard3 = new Card(cardTypes.HEART, 6);
//  print(testCard3.card);
//  Card testCard4 = new Card(cardTypes.CLUB, 7);
//  print(testCard4.card);
//  Card testCard5 = new Card(cardTypes.WIZARD, 14);
//  print(testCard5.card);
//  Card testCard6 = new Card(cardTypes.JESTER, 0);
//  print(testCard6.card);
//}

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
