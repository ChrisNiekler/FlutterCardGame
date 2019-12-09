import 'package:flutter/cupertino.dart';
import 'package:wizard/experimental/backend/playersUI.dart';
import 'package:wizard/logic/card.dart' as logic;
import 'package:wizard/logic/player.dart';
import 'package:wizard/logic/deck.dart';
import 'package:wizard/logic/cardType.dart';
import 'package:wizard/logic/wizardTrick.dart';

const List<int> numberRounds = [0, 0, 0, 20, 15, 12, 10];

class Wizard {
  // VARIABLES
  // cards
  logic.Card trumpCard;
  Deck deck = Deck();
  CardType trumpType;
  CardType toServe;
  List<logic.Card> playedCards = [];
  List<logic.Card> alreadyPlayedCards = [];

  // players
  int trickStarter = 0;
  int firstPlayer = 0;
  int lastPlayer;

  // round information
  List<Player> players;
  bool wizardIsPlayed = false;
  int roundNumber = 1;
  int lastRound;
  final int playerAmount;
  bool roundEnd = false;

  // CONSTRUCTOR
  Wizard({this.playerAmount}) {
    players = createPlayers(playerAmount);
    lastRound = numberRounds[playerAmount];
    lastPlayer = playerAmount - 1;
  }
  // returns the TrumpCard
  logic.Card takeTrumpCard() {
    if (deck.isNotEmpty()) {
      trumpCard = deck.takeCard();
      trumpType = trumpCard.cardType;
    }
    return trumpCard;
  }

  // distributes the card amongst the players
  void cardDistribution() {
    int lng = players.length;
    for (int i = 0; i < roundNumber; i++) {
      for (int j = 0; j < lng; j++) {
        players[j].handCards.add(deck.takeCard());
      }
    }
  }

  // the user plays a card
  bool userPlayCard({@required logic.Card choosenCard}) {
    playedCards.add(choosenCard);
    afterFirstPlayer();
    return players[0].handCards.remove(choosenCard);
  }

  // after the first player played we need to determine what card
  // has to be served
  void afterFirstPlayer() {
    determineToServe(toServe: toServe, playedCards: playedCards);
  }

  // todo needs to be changed once the first player is not 0
  logic.Card getPlayerCard({@required int playerID}) {
    return playedCards[playerID];
  }

  playersPlay() {
    for (int i = 1; i < playerAmount; i++) {
      setAllowedToPlay(
          player: players[i], wizardIsPlayed: wizardIsPlayed, toServe: toServe);
      playedCards.add(players[i].handCards.removeLast());
    }
  }

  bool checkEndOfRound() {
    if (players.last.handCards.length == 1) {
      if (roundNumber < lastRound) {
        return true;
      } else {
        endOfGame();
      }
    }
    return false;
  }

  void nextRound() {
    print('nextRound() was called');
    print('Round $roundNumber');
    roundNumber++;
    playedCards = [];
    print('new deck is created');
    deck = new Deck();
    cardDistribution();
    print('cards are distributed');
  }

  void nextTrick() {
    print('nextTrick() was called');
    playedCards = [];

    setAllowedToPlay(
        player: players[trickStarter],
        toServe: toServe,
        wizardIsPlayed: wizardIsPlayed);
  }

  void endOfGame() {}
}
