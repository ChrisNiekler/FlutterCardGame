import 'package:wizard/card.dart';
import 'package:wizard/cardType.dart';
import 'package:wizard/player.dart';
import 'humanPlayer.dart';
import 'package:wizard/deck.dart';
import 'dart:io';

class Round {
  Card trumpCard;
  CardType trumpType;
  int roundNumber;
  int maxRounds;
  int trickStarter;
  bool wizardIsPlayed = false;
  CardType toServe; // the type of card that has to be served
  List<Player> players;
  List<Card> playedCards = [];
  List<Card> alreadyPlayedCards = [];

  // creates a brand new Deck that gets shuffled twice
  Deck gameDeck = new Deck();

  Round(this.roundNumber, this.maxRounds, this.trickStarter, this.players);

  void playRound() {
    // involve the dealer??
    // distributes the cards evenly throughout the players

    cardDistribution();

    // after the distribution the card on top will determine the new trump
    determineTrump();

    // put bets
    tricking();
    print('');

    //play tricks
    for (int i = 1; i <= roundNumber; i++) {
      print('----------- Trick $i -----------');
      playTrick();
      wizardIsPlayed = false;
    }

    roundEvaluation();
    print('-------------------------------');
    players.forEach(
      (element) {
        element.tricks = 0;
      },
    );
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
    playCards();
    print('-------------------------------');
    toServe = null;
    playedCards = [];
  }

  /*ask every player to play a card*/

  void playCards() {
    String name = '';
    String temp = '';
    Card highestPlayedCard;
    Player trickWinner;

    Player gamer;
    for (int i = 0, n = players.length; i < n; i++) {
      gamer = players[trickStarter];

      name = gamer.name;
      print('$name\'s turn.');
      setAllowedToPlay(gamer);
      gamer.creatingPlayableHandCardsList();
      // start of player choice
      if (!gamer.ai) {
        // the human player will play a card
        temp = CardTypeHelper.getValue(trumpType);

        if (trumpType != null) {
          print('The trump is $temp');
          playedCards.add((gamer as HumanPlayer).humanPlayCard());
        } else {
          print('There is no trump in this round!');
        }
      } else {
        // the ai will  play a card
        if (playedCards.length == 0) {
          // when no card is played yet
          playedCards.add(
            gamer.playCard(
              1,
              trump: trumpType,
            ),
          );
        } else {
          playedCards
              .add(gamer.playCard(1, trump: trumpType, foe: playedCards[0]));
        }
      }

      temp = playedCards[playedCards.length - 1].card;
      if (temp == 'WIZARD') {
        wizardIsPlayed = true;
      }
      print('$name played $temp');

      // check if the card is higher then what is played yet
      if (playedCards.length > 1) {
        highestPlayedCard =
            playedCards.last.compare(highestPlayedCard, trumpType);
        if (highestPlayedCard == playedCards.last) {
          trickWinner = gamer;
          print('${gamer.name} is leading now');
        }
      } else if (playedCards.length == 1) {
        highestPlayedCard = playedCards[0];
        trickWinner = gamer;
        print('${trickWinner.name} is leading now');
      }

      // determine the color that has to be served
      // when a wizard is played as first card, everybody else can play
      // anything they want, wizard is trump but doesn't have to be played

      // what to serve
      if (toServe == null) {
        // todo put in method
        toServe = playedCards[playedCards.length - 1].cardType;
        temp = CardTypeHelper.getValue(toServe);

        if (toServe == CardType.WIZARD) {
          print('WIZARD was played, everybody else can play any card.');
          toServe = CardType.WIZARD;
        } else if (toServe == CardType.JESTER) {
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
      alreadyPlayedCards.addAll(playedCards);
      gamer.playableHandCards = [];

      // sleeper --> just for the console game
      // so it looks more nature
      sleep(const Duration(seconds: 1));
      trickStarter++;
      if (!(trickStarter < players.length)) {
        trickStarter = 0;
      }
    }

    // end of for each
    print('${trickWinner.name} has won the trick!');
    trickStarter = trickWinner.id;
    players[players.indexOf(trickWinner)].tricks++;
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
          CardType type = crd.cardType;
          if (type == toServe) {
            crd.allowedToPlay = true;
            n++;
          } else if (type == CardType.WIZARD || type == CardType.JESTER) {
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
    CardType type = trumpCard.cardType;
    String cardName = trumpCard.card;
    String temp;
    print('');

    // print the current trump card
    if (!(type == CardType.JESTER || type == CardType.WIZARD)) {
      temp = trumpCard.typeToString();
      print('The open card is $cardName, therefore the trump is $temp');
      trumpType = type;
    } else if (type == CardType.JESTER) {
      // when jester is trump card there is no trump
      print(
          'The open card is $cardName, therefore there is no trump for this round.');
      trumpType = null;
    } else if (type == CardType.WIZARD) {
      // when wizard is trump card then the dealer picks the trump
      print(
          'The open card is $cardName, therefore the dealer picks the trump.');
      trumpType = players[trickStarter].pickTrumpCard();
    }
    print('');
  }

  void tricking() {
    int betsNumber = 0;
    int p = trickStarter;
    for (int i = 0, n = players.length; i < n; i++) {
      players[p % n].putBet(roundNumber, betsNumber, trump: trumpType);
      p++;
      betsNumber += players[p % n].bet;
    }
  }

  void determineLastPlayer() {
    if (trickStarter == 0)
      players.last.lastPlayer = true;
    else
      players[trickStarter - 1].lastPlayer = true;
  }

  void roundEvaluation() {
    // todo test this
    players.forEach(
      (gamer) {
        if (gamer.tricks == gamer.bet) {
          gamer.points += 20; // for being right
          gamer.points += (10 * gamer.tricks); // 10 for each trick
        } else {
          // subtract 10 points times the distance between bet and tricks
          gamer.points -= 10 * (gamer.tricks - gamer.bet).abs();
        }
        gamer.printPoints();
      },
    );
  }
}
