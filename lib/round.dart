import 'package:wizard2/card.dart';
import 'package:wizard2/player.dart';
import 'humanPlayer.dart';
import 'package:wizard2/deck.dart';
import 'dart:io';

class Round {
  Card trump;
  int roundNumber;
  int maxRounds;
  int dealerID;
  List<Player> players;
  List<Card> playedCards = [];
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

    // print the current trump card
    print('The trump is: ');
    print(this.trump.card);
    print('\n');
    playCards();
  }

  // distributes the cards
  // depending on how many players and which round
  void cardDistribution() {
    int lng = players.length;
    for (int i = 0; i < roundNumber; i++) {
      for (int j = 0; j < lng; j++) {
        players[j].handCards.add(gameDeck.takeCard());
      }
    }
  }
  /* todo asked every player to play one card
   * to do that you have to specify which cards are allowed to be played
   *
   */

  void playCards() {
    int size;
    String name = '';
    String input = '';
    int cardNr;
    bool allowed;
    players.forEach((gamer) {
      allowed = false;
      cardNr = -1;
      size = gamer.handCards.length;
      name = gamer.name;
      print('$name\'s turn.');
      gamer.printHandCardsToConsole();
      do {
        print('Please pick one of your $size cards (by index) to play: ');
        input = stdin.readLineSync();
        if (_isNumeric(input)) {
          cardNr = int.parse(input);
        }
        if (cardNr >= 0 && cardNr < size) {
          allowed = true;
        }
      } while (!allowed);
      playedCards.add(gamer.playCard(cardNr));
      input = playedCards[playedCards.length - 1].card;
      print('$name played $input');

      print('\n');
    });
  }
}

void tricking() {}
void evaluation() {}

bool _isNumeric(String str) {
  if (str == null) {
    return false;
  }
  return int.tryParse(str) != null;
}
