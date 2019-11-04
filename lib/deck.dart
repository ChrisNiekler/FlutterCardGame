import 'package:wizard2/card.dart';
import 'package:wizard2/types.dart';
import 'dart:math';

class Deck {
  List<Card> deck = new List(60);
  int topOfDeck = 0;
  void distribution() {}

  /*createDeck() will create a new deck of cards in increasing order*/
  void createDeck() {
    //todo add Images for the GUI when ready
    // clubs (♣), diamonds (♦), hearts (♥) and spades (♠
    int index = 0;
    // first loop for the four different types
    for (int i = 0; i < 4; i++) {
      // second loop for the fourteen different cards
      for (int j = 0; j < 15; j++) {
        if (j == 0) {
          this.deck[index] = new Card(cardTypes.values[4], j);
        } else if (j == 14) {
          this.deck[index] = new Card(cardTypes.values[5], j);
        } else {
          this.deck[index] = new Card(cardTypes.values[i], j);
        }
        index++;
      }
    }
  }

  /* Takes a existing deck and returns it in an arbitrary order
* using the Knuth shuffle a.k.a. Fisher-Yates Shuffle Algorithm*/
  void shuffleDeck() {
    _knuthShuffle();
    _knuthShuffle();
  }

  /*Implementation of the Knuth Shuffle Algorithm*/
  void _knuthShuffle() {
    Card temp;
    int random;
    for (int i = this.deck.length; i > 0; i--) {
      // generate a random number between 0 and i => [0,i)
      random = Random().nextInt(i);
      // safe the current card in temp
      temp = this.deck[i - 1];
      this.deck[i - 1] = this.deck[random];
      this.deck[random] = temp;
    }
  }

// for testing only
  void printDeckToConsole() {
    this.deck.forEach((element) => print(element.card));
  }
}
