import 'package:wizard2/card.dart';
import 'package:wizard2/cardTypes.dart';
import 'package:wizard2/player.dart';
import 'package:wizard2/deck.dart';

class Round {
  Card trump;
  int roundNumber;
  int maxRounds;
  int dealerID;
  List<Player> players;
  // creates a brand new Deck that gets shuffled twice
  Deck gameDeck = new Deck();

  Round(this.roundNumber, this.maxRounds, this.dealerID, this.players);

  void playRound() {
    // distributes the cards evenly throughout the players
    // todo involve the dealer
    cardDistribution();

    // after the distribution the card on top will be the new trump
    this.trump = gameDeck.takeCard();
    print('\n');

    // prints out all the cards of all the players to the console
    int cardsInHand = players[0].handCards.length;
    print('cards in hand $cardsInHand');
    players.forEach((element) {
      String n = element.name;
      print('Playername: $n');
      print('Cards in hand!');
      element.printHandCardsToConsole();
      print('\n');
    });
    // print the current trump card
    print('The trump is: ');
    print(this.trump.card);
  }

  // distributes the cards
  void cardDistribution() {
    int lng = players.length;
    for (int i = 0; i < roundNumber; i++) {
      for (int j = 0; j < lng; j++) {
        players[j].handCards.add(gameDeck.takeCard());
      }
    }
  }

  void playCards() {}
}

void tricking() {}
void evaluation() {}
