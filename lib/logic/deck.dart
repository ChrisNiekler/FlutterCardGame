import 'package:wizard/logic/card.dart';
import 'package:wizard/logic/cardType.dart';
import 'dart:math';
/* A new instance of Deck will automatically create a Deck of 60 Cards
   which are already shuffeld twice.
 */

class Deck {
  List<Card> deck = [];

  /* Returns the card that is on top of the Stack */
  Card takeCard() {
    return deck.removeLast();
  }

  bool isNotEmpty() {
    return deck.isNotEmpty;
  }

  void aiRemoveCard(int number) {
    deck.removeAt(number);
  }

  Card aiShowCard(int number) {
    return deck[number];
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
          // if the value of the card is 0 then
          // the card type is Jester
          this.deck.add(
              new Card(CardType.values[4], j, passiveType: CardType.values[i]));
        } else if (j == 14) {
          // if the value of the card is 14 then
          // the card type is Wizard
          this.deck.add(
              new Card(CardType.values[5], j, passiveType: CardType.values[i]));
        } else {
          // the card type varies between the common types
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

  int size() {
    return this.deck.length;
  }

  /* Constructor
  * When creating a new instance of Deck, the cards will be created and shuffled;*/
  Deck() {
    this._createDeck();
    this.shuffleDeck();
  }
}
