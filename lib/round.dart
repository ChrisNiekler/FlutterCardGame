import 'package:wizard2/card.dart';
import 'package:wizard2/cardTypes.dart';
import 'package:wizard2/player.dart';
import 'humanPlayer.dart';
import 'package:wizard2/deck.dart';
import 'dart:io';

class Round {
  Card trump;
  int roundNumber;
  int maxRounds;
  int dealerID;
  cardTypes toServe = cardTypes.HEART; // the type of card that has to be served
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

  /*ask every player to play a card*/

  void playCards() {
    int size;
    String name = '';
    String input = '';
    int cardNr;
    bool inputAllowed;

    // todo check if playable cards are in hand
    // if no playable card is in hand the player can play any card
    // the first player can play any card

    players.forEach(
      (gamer) {
        inputAllowed = false;
        cardNr = -1;
        size = gamer.handCards.length;
        name = gamer.name;
        print('$name\'s turn.');
        playable(gamer);
        // start of player choice
        if (!gamer.ai) {
          gamer.printHandCardsToConsole();
          do {
            print('Please pick one of your $size cards (by index) to play: ');
            input = stdin.readLineSync();
            if (_isNumeric(input)) {
              cardNr = int.parse(input);
            }
            if (cardNr >= 0 && cardNr < size) {
              inputAllowed = true;
            }
          } while (!inputAllowed);
          playedCards.add(gamer.playCard(cardNr));
        } else {
          // if an AI playCard will be called with -1
          playedCards.add(gamer.playCard(-1));
        }

        // end of player choice

        input = playedCards[playedCards.length - 1].card;
        print('$name played $input');

        print('');
      },
    );
  }

  void checkIfCardsPlayable(Player currentPlayer) {
    // todo implement
    // this method should iterate over the players cards and mark if they are
    // allowedToPlay (mark their bool)
  }

  /*check if the player has cards th
   the first player plays any card he wants
   the second player has to play  the same color
   if he has a card of that color, if not he can
   play any card he wants
   JESTERS and WIZARDS can be played even if the player
   has a card of a servable color*/

  List<Card> playable(Player player) {
    int n = 0;
    // if the toServer Value is NULL there is no card played yet
    List<Card> hand = player.handCards;
    if (toServe == null) {
      hand.forEach(
        (crd) {
          crd.allowedToPlay = true;
          n++;
        },
      );
    } else {
      // else every card in the hand will be compared if it is from type
      // that is required
      hand.forEach(
        (crd) {
          if (crd.cardType == toServe) {
            crd.allowedToPlay = true;
            n++;
          }
        },
      );
    }
    if (n == 0) {
      // if no card is from the required type
      // any card can be played
      hand.forEach(
        (crd) {
          crd.allowedToPlay = true;
        },
      );
    }

    return hand;
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
