import 'package:wizard2/card.dart';
import 'package:wizard2/cardTypes.dart';
import 'package:wizard2/player.dart';
import 'humanPlayer.dart';
import 'package:wizard2/deck.dart';
import 'dart:io';
import 'dart:math';
import 'package:wizard2/ki.dart';

class Round {
  Card trumpCard;
  cardTypes trumpType;
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

    // put bets
    tricking(); // does nothing so far

    //play tricks
    for (int i = 1; i <= roundNumber; i++) {
      print('---- Trick $i ----');
      playTrick();
    }

    roundEvaluation(); // does nothing so far
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
    // todo the winner of a trick starts the next trick
    playCards();
    print('-------------------------------');
    toServe = null;
    trickEvaluation();
    playedCards = [];
  }

  /*ask every player to play a card*/

  void playCards() {
    String name = '';
    String temp = '';

    players.forEach(
      (gamer) {
        //inputAllowed = false;
        //cardNr = -1;

        name = gamer.name;
        print('$name\'s turn.');
        setAllowedToPlay(gamer);
        gamer.creatingPlayableHandCardsList();
        // start of player choice
        if (!gamer.ai) {
          humanPlayCard(gamer);
        } else {
          // AI will be called with number of cards in hand
          //playedCards.add(gamer.playCard(gamer.handCards.length));

          //Aufrufen der AI mit trump und highest Card
//          Card findHighestCard(List<Card> cards) {
//            if (cards.length == null)
//              //betAI()
//              return playedCards[0];
//            else {
//              Card highestCard = playedCards[0];
//              for (int i = 1; i < playedCards.length; i++) {
//                highestCard = highestCard.compare(playedCards[i], trumpCard);
//              }
//              return highestCard;
//            }
//          }

          playedCards
              .add(gamer.playCard(1, trump: trumpType, foe: playedCards[0]));
        }

        temp = playedCards[playedCards.length - 1].card;
        print('$name played $temp');

        // determine the color that has to be served
        // todo when a wizard is played as first card, everybody else can play
        //       anything they want, wizard is trump but doesn't have to be played

        // todo what to do when a jester is played
        if (toServe == null) {
          toServe = playedCards[playedCards.length - 1].cardType;
          temp =
              toServe.toString().substring(toServe.toString().indexOf('.') + 1);
          print('$temp has to be served!');
        }

        // reset all temp data
        print('');
        resetAllowedToPlay(gamer);
        gamer.playableHandCards = [];
      },
    );
  }

  void humanPlayCard(Player gamer) {
    bool inputAllowed = false;
    String input = '';
    int size;
    int cardNr = -1;
    size = gamer.handCards.length;

    gamer.printHandCardsToConsole();
    do {
      print('Please pick one of your $size cards (by index) to play: ');
      input = stdin.readLineSync();
      if (_isNumeric(input)) {
        cardNr = int.parse(input);
      }
      if (cardNr >= 0 && cardNr < size) {
        if (gamer.handCards[cardNr].allowedToPlay) {
          inputAllowed = true;
        } else {
          print('Please pick another card!');
        }
      }
    } while (!inputAllowed);
    playedCards.add(gamer.playCard(cardNr));
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

  List<Card> setAllowedToPlay(Player player) {
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

  List<Card> resetAllowedToPlay(Player player) {
    List<Card> hand = player.handCards;
    hand.forEach(
      (crd) {
        crd.allowedToPlay = false;
      },
    );
    return hand;
  }

  void determineTrump() {
    this.trumpCard = gameDeck.takeCard();
    cardTypes type = trumpCard.cardType;
    String cardName = trumpCard.card;
    String temp;
    print('');

    // print the current trump card
    //  todo when wizard then dealer picks trump
    //  todo what jester no trump
    if (!(type == cardTypes.JESTER || type == cardTypes.WIZARD)) {
      temp = trumpCard.cardType
          .toString()
          .substring(trumpCard.cardType.toString().indexOf('.') + 1);
      print('The open card is $cardName, therefore the trump is $temp');
      trumpType = type;
    } else if (type == cardTypes.JESTER) {
      print(
          'The open card is $cardName, therefore there is no trump for this round.');
      trumpType = null;
    } else if (type == cardTypes.WIZARD) {
      print(
          'The open card is $cardName, therefore the dealer picks the trump.');
      pickTrumpCard(players[dealerID]);
    }
    print('');
  }

  void pickTrumpCard(Player player) {
    String name = player.name;
    String type;
    // todo implement this
    // todo ask the player who deals to pick the card
    trumpType = cardTypes.values[Random().nextInt(4)];
    type =
        trumpType.toString().substring(trumpType.toString().indexOf('.') + 1);
    print('$name pickt $type (yet random)');
  }
}

void tricking() {}
void roundEvaluation() {}
void trickEvaluation() {
  // todo give a token to the trick winner
}

bool _isNumeric(String str) {
  if (str == null) {
    return false;
  }
  return int.tryParse(str) != null;
}
