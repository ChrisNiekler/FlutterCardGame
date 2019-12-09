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
  logic.Card trumpCard;
  List<Player> players;
  Deck deck = Deck();
  CardType trumpType;
  bool wizardIsPlayed = false;
  int trickStarter = 0;
  CardType toServe;
  List<logic.Card> playedCards = [];
  List<logic.Card> alreadyPlayedCards = [];
  int roundNumber = 1;
  int lastRound;
  final int playerAmount;
  bool roundEnd = false;

  // CONSTRUCTOR
  Wizard({this.playerAmount}) {
    players = createPlayers(playerAmount);
    lastRound = numberRounds[playerAmount];
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

  bool userPlayCard({@required logic.Card choosenCard}) {
    playedCards.add(choosenCard);
    afterFirstPlayer();
    return players[0].handCards.remove(choosenCard);
  }

  void afterFirstPlayer() {
    determineToServe(toServe: toServe, playedCards: playedCards);
  }

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
