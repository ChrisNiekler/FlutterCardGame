import 'package:wizard2/card.dart';
import 'package:wizard2/types.dart';

class Deck {
  List<Card> deck = new List(60);
  void distribution() {}
  void shuffleCards() {}
}

Deck createDeck() {
  // clubs (♣), diamonds (♦), hearts (♥) and spades (♠)
  Deck output = new Deck();
  int index = 0;
  // first loop for the four different types
  for (int i = 0; i < 4; i++) {
    // second loop for the fourteen different cards
    for (int j = 0; j < 15; j++) {
      //   Card testCard = new Card(cardTypes.SPADE, 4)
      if (j == 0) {
        output.deck[index] = new Card(cardTypes.values[4], j);
      } else if (j == 14) {
        output.deck[index] = new Card(cardTypes.values[5], j);
      } else {
        output.deck[index] = new Card(cardTypes.values[i], j);
      }
      index++;
    }
  }
  return output;
}
