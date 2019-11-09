import 'package:wizard2/card.dart';
import 'package:wizard2/cardTypes.dart';
import 'package:wizard2/player.dart';
import 'humanPlayer.dart';
import 'package:wizard2/deck.dart';
import 'dart:io';

class Round {
  Card trumpCard;
  cardTypes trumpType;
  int roundNumber;
  int maxRounds;
  int dealerID;
  bool wizardIsPlayed = false;
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
    tricking(trumpCard.cardType, roundNumber); // does nothing so far
    print('');

    //play tricks
    for (int i = 1; i <= roundNumber; i++) {
      print('----------- Trick $i -----------');
      playTrick();
      wizardIsPlayed = false;
    }

    roundEvaluation();
    print('-------------------------------');
    sleep(const Duration(seconds: 3));
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
    // todo the winner of a trick starts the next trick F4N

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
    Card highestPlayedCard;
    Player trickWinner;

    players.forEach(
      (gamer) {
        name = gamer.name;
        print('$name\'s turn.');
        setAllowedToPlay(gamer);
        gamer.creatingPlayableHandCardsList();
        // start of player choice
        if (!gamer.ai) {
          // the human player will play a card
          playedCards.add((gamer as HumanPlayer).humanPlayCard());
        } else {
          // the ai will  play a card
          playedCards
              .add(gamer.playCard(1, trump: trumpType, foe: playedCards[0]));
        }

        temp = playedCards[playedCards.length - 1].card;
        print('$name played $temp');

        // check if the card is higher then what is played yet
        if (playedCards.length > 1) {
          highestPlayedCard =
              playedCards.last.compare(highestPlayedCard, trumpType);
          if (highestPlayedCard == playedCards.last) {
            trickWinner = gamer;
            temp = gamer.name;
            print('$temp is leading now');
          }
        } else if (playedCards.length == 1) {
          highestPlayedCard = playedCards[0];
          trickWinner = gamer;
          temp = trickWinner.name;
          print('$temp is leading now');
        }

        // determine the color that has to be served
        // when a wizard is played as first card, everybody else can play
        // anything they want, wizard is trump but doesn't have to be played

        // what to serve
        if (toServe == null) {
          // todo put in method F4N
          toServe = playedCards[playedCards.length - 1].cardType;
          temp =
              toServe.toString().substring(toServe.toString().indexOf('.') + 1);
          if (toServe == cardTypes.WIZARD) {
            print('WIZARD was played, everybody else can play any card.');
            toServe = cardTypes.WIZARD;
          } else if (toServe == cardTypes.JESTER) {
            print('JESTER was played as first card.');
            print('The next card will determine the played color');
            toServe = null;
          } else {
            print('$temp has to be served!');
          }
        }

        // reset all temp data
        print('');

        resetAllowedToPlay(gamer);
        gamer.playableHandCards = [];

        // sleeper --> just for the console game
        // so it looks more nature
        sleep(const Duration(seconds: 1));
      },
    ); // end of for each
    temp = trickWinner.name;
    print('$temp has won the trick!');
    players[players.indexOf(trickWinner)].tricks++;
    // todo give points

    trickEvaluation();
  } // end of playCards()

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
    if (n == 0 || wizardIsPlayed) {
      // if no card is from the required type
      // of if a wizard was played
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
    if (!(type == cardTypes.JESTER || type == cardTypes.WIZARD)) {
      temp = trumpCard.cardType
          .toString()
          .substring(trumpCard.cardType.toString().indexOf('.') + 1);
      print('The open card is $cardName, therefore the trump is $temp');
      trumpType = type;
    } else if (type == cardTypes.JESTER) {
      // when jester is trump card there is no trump
      print(
          'The open card is $cardName, therefore there is no trump for this round.');
      trumpType = null;
    } else if (type == cardTypes.WIZARD) {
      // when wizard is trump card then the dealer picks the trump
      print(
          'The open card is $cardName, therefore the dealer picks the trump.');
      players[dealerID].pickTrumpCard();
    }
    print('');
  }

  void tricking(cardTypes trump, int round) {
    bool lastPlayer = false;
    int betsNumber = 0;
    players.forEach(
      (gamer) {
        if(gamer.name == 'Quadro') lastPlayer = true;
        gamer.putBet(round, betsNumber, lastPlayer, trump: trump);
        betsNumber += gamer.getBetsNumber();
      },
    );
  }

  void trickEvaluation() {
    // todo see if this method is still necessary
  }

  void roundEvaluation() {
    // todo print the current points
    players.forEach(
      (gamer) {
        if (gamer.tricks == gamer.bet) {
          //todo get some points
        } else {
          // todo distract some points
        }
        gamer.printPoints();
      },
    );
  }
}
