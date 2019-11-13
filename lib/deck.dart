import 'package:wizard2/card.dart';
import 'package:wizard2/cardType.dart';
import 'dart:math';

class Deck {
  List<Card> deck = [];
  int _topOfDeck = 0;

  /* Returns the card that is on top of the Stack */
  Card takeCard() {
    return deck.removeAt(0);
  }

  /* _createDeck() will create a new deck of cards in increasing order*/
  void _createDeck() {
    //todo add Images for the GUI when ready F4N
    // clubs (♣), diamonds (♦), hearts (♥) and spades (♠

    // first loop for the four different types
    for (int i = 0; i < 4; i++) {
      // second loop for the fourteen different cards
      for (int j = 0; j < 15; j++) {
        if (j == 0) {
          this.deck.add(new Card(CardType.values[4], j));
        } else if (j == 14) {
          this.deck.add(new Card(CardType.values[5], j));
        } else {
          this.deck.add(new Card(CardType.values[i], j));
        }
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

  /* Constructor
  * When creating a new Deck, the cards will be created and shuffled;*/
  Deck() {
    this._createDeck();
    this.shuffleDeck();
  }
}
