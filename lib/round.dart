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
  cardTypes toServe; // the type of card that has to be served
  List<Player> players;
  List<Card> playedCards = [];
  // creates a brand new Deck that gets shuffled twice
  Deck gameDeck = new Deck();

  Round(this.roundNumber, this.maxRounds, this.dealerID, this.players);

  void playRound() {
    // todo involve the dealer
    // distributes the cards evenly throughout the players

    cardDistribution();

    // after the distribution the card on top will determine the new trump
    determineTrump();

    for (int i = 1; i <= roundNumber; i++) {
      print('---- Trick $i ----');
      playTrick();
    }
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

  void playTrick() {
    playCards();
    print('-------------------------------');
  }

  /*ask every player to play a card*/

  void playCards() {
    String name = '';
    String input = '';

    players.forEach(
      (gamer) {
        //inputAllowed = false;
        //cardNr = -1;

        name = gamer.name;
        print('$name\'s turn.');
        playable(gamer);
        // start of player choice
        if (!gamer.ai) {
          humanPlayCard(gamer);
        } else {
          // if an AI playCard will be called with -1
          playedCards.add(gamer.playCard(gamer.handCards.length));
        }
        // end of player choice

        input = playedCards[playedCards.length - 1].card;
        print('$name played $input');

        // determine the color that has to be served
        // todo what to do when a wizard is played
        // todo what to do when a jester is played
        if (toServe == null) {
          toServe = playedCards[playedCards.length - 1].cardType;
          print('$toServe has to be served!');
        }
        print('');
      },
    );
  }

  void humanPlayCard(Player gamer) {
    bool inputAllowed = false;
    String input = '';
    int size;
    int cardNr = -1;
    size = gamer.handCards.length;
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
    }
  }

  void checkIfCardsPlayable(Player currentPlayer) {
    // todo implement
    // this method should iterate over the players cards and mark if they are
    // allowedToPlay (mark their bool)
  }

  /*check if the player has cards that are playable
   the first player plays any card he wants
   the second and later player has to play  the same color
   if he has a card of that color, if not he can
   play any card he wants
   JESTERS and WIZARDS can be played even if the player
   has a card of a servable color*/

  List<Card> playable(Player player) {
    int n = 0;
    // if the toServe Value is NULL there is no card played yet
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
          cardTypes type = crd.cardType;
          if (type == toServe) {
            crd.allowedToPlay = true;
            n++;
          } else if (type == cardTypes.WIZARD || type == cardTypes.JESTER) {
            crd.allowedToPlay = true;
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

  void determineTrump() {
    this.trump = gameDeck.takeCard();
    cardTypes type = trump.cardType;
    String cardName = trump.card;
    String temp;
    print('');

    // print the current trump card
    //  todo what to do when the trump is a wizard
    //  todo what to do when the trump is a jester
    if (!(type == cardTypes.JESTER || type == cardTypes.WIZARD)) {
      temp = trump.cardType
          .toString()
          .substring(trump.cardType.toString().indexOf('.') + 1);
      print('The open card is $cardName, therefore the trump is $temp');
    } else if (type == cardTypes.JESTER) {
      print(
          'The open card is $cardName, therefore there is no trump for this round.');
    } else if (type == cardTypes.WIZARD) {
      print(
          'The open card is $cardName, therefore the dealer picks the trump.');
    }
    print('');
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
