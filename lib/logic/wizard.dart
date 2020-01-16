import 'package:flutter/cupertino.dart';
import 'package:wizard/experimental/backend/playersUI.dart';
import 'package:wizard/logic/gamecard.dart';
import 'package:wizard/logic/player.dart';
import 'package:wizard/logic/deck.dart';
import 'package:wizard/logic/cardType.dart';
import 'package:wizard/logic/wizardTrick.dart';
import 'dart:math';

const List<int> numberRounds = [0, 0, 0, 20, 15, 12, 10];

/*
  This is the logic of the game,
  here is where everything of the backend happens
 */
class Wizard {
  // VARIABLES
  // cards
  GameCard trumpCard;
  Deck _deck = Deck();
  CardType trumpType;
  CardType toServe;
  List<GameCard> playedCards = [];
  List<GameCard> alreadyPlayedCards = [];
  GameCard aiTookThisCard;
  int indexOfTakenCard;
  GameCard foe;
  GameCard highestCard;

  // players
  int trickStarter;
  int roundStarter;
  int lastPlayer;
  int currentPlayer;
  bool firstPlayer;
  bool trickNotOver = true;

  // round information
  List<Player> players;
  List<GameCard> tableCards;
  int playersBet;
  bool wizardIsPlayed = false;
  int roundNumber = 1;
  int lastRound;
  final int playerAmount;
  bool roundEnd = false;
  int betsNumber;

  // CONSTRUCTOR
  Wizard({this.playerAmount}) {
    players = createPlayers(playerAmount);
    lastRound = numberRounds[playerAmount];
    lastPlayer = playerAmount - 1;
    roundStarter = _whoStarts(playerAmount);
    tableCards = new List(this.playerAmount);
    roundStarter = 0; //for testing reasons TODO delete this line
    trickStarter = roundStarter;
//    currentPlayer = roundStarter;
    currentPlayer = trickStarter;
  }

  /*
  Returns the TrumpCard
   */
  GameCard takeTrumpCard() {
    if (_deck.isNotEmpty()) {
      trumpCard = _deck.takeCard();
      trumpType = trumpCard.cardType;
    }
    return trumpCard;
  }

  /*
  Distributes the card amongst the players
   */
  void cardDistribution() {
    int lng = players.length;
    for (int i = 0; i < roundNumber; i++) {
      for (int j = 0; j < lng; j++) {
        players[j].handCards.add(_deck.takeCard());
      }
    }
  }

  // the user plays a card
  bool userPlayCard({@required GameCard chosenCard}) {
    playedCards.add(chosenCard);
    afterFirstPlayer();
    return players[0].handCards.remove(chosenCard);
  }

  // after the first player played we need to determine what card
  // has to be served
  void afterFirstPlayer() {
    determineToServe(toServe: toServe, playedCards: playedCards);
  }

  // todo needs to be changed once the first player is not 0
  GameCard getPlayerCard({@required int playerID}) {
    return playedCards[playerID];
  }

  /*
  TODO add some description
   */
  playersPlay() {
    Player trickWinner;
    Player gamer;
    int i;
    do {
      i = currentPlayer;
      //for (int i = 1; i < playerAmount; i++) {
      gamer = players[i];
      // check if the card is higher then what is played yet
      if (playedCards.length > 1) {
        highestCard = playedCards.last.compare(highestCard, trumpType);
        if (highestCard == playedCards.last) {
          trickWinner = gamer;
          print('${gamer.name} is leading now');
        }
      } else if (playedCards.length == 1) {
        highestCard = playedCards[0];
        trickWinner = gamer;
        print('${trickWinner.name} is leading now');
      }

      foe = playedCards.last;
      setAllowedToPlay(
          player: players[i], wizardIsPlayed: wizardIsPlayed, toServe: toServe);
      gamer.creatingPlayableHandCardsList();
      //TODO DRY?
      if (i == 1) {
        print('i am KuenstlicheIntelligenz');
        aiTookThisCard = players[i].playCard(0,
            trump: trumpType,
            foe: foe,
            roundNumber: roundNumber,
            playerNumber: playerAmount,
            alreadyPlayedCards: alreadyPlayedCards,
            playedCards: playedCards,
            highestCard: highestCard);
        _playTheCardAiHelper(i);
      } else if (i == 2) {
        print('i am Ai');
        aiTookThisCard = players[i].playCard(0, trump: trumpType, foe: foe);
        _playTheCardAiHelper(i);
      } else if (i == 3) {
        print('i am Ki');
        aiTookThisCard = players[i].playCard(0,
            trump: trumpType,
            foe: foe,
            roundNumber: roundNumber,
            playerNumber: playerAmount,
            alreadyPlayedCards: alreadyPlayedCards,
            highestCard: highestCard);
        _playTheCardAiHelper(i);
      } else if (i == 4) {
        print('i am KuenstlicheIntelligenz');
        aiTookThisCard = players[i].playCard(0,
            trump: trumpType,
            foe: foe,
            roundNumber: roundNumber,
            playerNumber: playerAmount,
            alreadyPlayedCards: alreadyPlayedCards,
            playedCards: playedCards,
            highestCard: highestCard);
        _playTheCardAiHelper(i);
      } else if (i == 5) {
        print('i am Ai');
        aiTookThisCard = players[i].playCard(0, trump: trumpType, foe: foe);
        _playTheCardAiHelper(i);
      }

      //todo this is needed for dynamic programming
//      if(players[i].toString() == 'Ki'){
//        print('i am ki');
//      }
//      else if (players[i].toString() == 'KuenstlicheIntelligenz') {
//        print('i am kuenstliche...');
//      }
//      else if (players[i].toString() == 'Ai') {
//        print('i am ai');
//      }

      //this was needed before
//      playedCards.add(players[i].handCards.removeLast());
      _nextPlayer();
    } while (trickNotOver);
    trickNotOver = true;
    trickWinner = players[0];
  }

  /*
  TODO add some description
   */
  bool checkEndOfRound() {
    if (players.last.handCards.length == 0) {
      if (roundNumber < lastRound) {
        return true;
      } else {
        endOfGame();
      }
    }
    return false;
  }

  /*
  TODO add some description
   */
  void nextRound() {
    print('nextRound() was called');
    print('Round $roundNumber');
    roundNumber++;
    playedCards = [];
    print('new deck is created');
    _deck = new Deck();
    _nextRoundStarter();
    for (int i = 0; i < playerAmount; i++) {
      players[i].handCards = [];
      players[i].playableHandCards = [];
    }
    cardDistribution();
    print('cards are distributed');
  }

  /*
  TODO add some description
   */
  void nextTrick() {
    print('nextTrick() was called');
    playedCards = [];

    for (int i = 0; i < playerAmount; i++) {
      players[i].playableHandCards = [];
    }

    setAllowedToPlay(
        player: players[trickStarter],
        toServe: toServe,
        wizardIsPlayed: wizardIsPlayed);
  }

  /*
  TODO  implement if we actually need it
  TODO add some description
   */
  void endOfGame() {}

  /*
  This method returns the next roundStarter, which is always the player
  next to the last roundStarter. If the last player played (e.g. playerid=5 for
  a five player game) then the roundStarter is set back to 0 (the first player).
   */
  void _nextRoundStarter() {
//    if (trickStarter + 1 < playerAmount) {
//      trickStarter++;
//    } else {
//      trickStarter = 0;
//    }
    if (roundStarter + 1 < playerAmount) {
      roundStarter++;
    } else {
      roundStarter = 0;
    }
  }

  /*
  TODO add some description
   */
  int _findIndexHelper(GameCard helperCard, List<GameCard> handCards) {
    int amountOfHandcards = handCards.length;
    for (int i = 0; i < amountOfHandcards; i++) {
      if (helperCard == handCards.elementAt(i)) return i;
    }
  }

  /*
  TODO add some description
   */
  void _playTheCardAiHelper(int i) {
    indexOfTakenCard = _findIndexHelper(aiTookThisCard, players[i].handCards);
    playedCards.add(players[i].handCards.removeAt(indexOfTakenCard));
  }

  /*
  TODO add some description
   */
  void determineLastPlayer() {
    if (trickStarter == 0)
      players.last.lastPlayer = true;
    else
      players[trickStarter - 1].lastPlayer = true;
  }

/*
  TODO add some description
   */
  void determineFirstPlayer() {
    for (int i = 0; i < players.length; i++) {
      if (players[i].id == trickStarter) players[i].firstPlayer = true;
    }
  }

/*
  TODO add some description
   */
  void putInTheRightBetInList(int playerByIndex, int betNumber) {
    players[playerByIndex].betsList.add(betNumber);
  }

/*
  TODO add some description
   */
  int getBetFromList(int playerByIndex, int roundNumber) {
    return players[playerByIndex].betsList[roundNumber - 1];
  }

/*
  This method changes the value of the currentPlayer until the currentPlayer is
  the last player then it will change the value of trickNotOver to false;
   */
  void _nextPlayer() {
    if (currentPlayer == lastPlayer) {
      trickNotOver = false;
    }
    if (currentPlayer + 1 == playerAmount) {
      currentPlayer = 0;
    } else {
      currentPlayer++;
    }
  }

/*
  TODO add some description
  TODO implement if needed
   */
  void startGame() {}
}

/*
  TODO add some description
   */
int _whoStarts(int players) {
  return Random().nextInt(players);
}
