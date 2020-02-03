import 'package:flutter/cupertino.dart';
import 'package:wizard/application/backend/playersUI.dart';
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
  GameCard usersChoosenCard;
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
  int betsNumber = 0;
  int difficulty;

  // CONSTRUCTOR
  Wizard({this.playerAmount, this.difficulty}) {
    players = createPlayers(playerAmount, difficulty);
    lastRound = numberRounds[playerAmount];
    lastPlayer = playerAmount - 1;
//    roundStarter = _whoStarts(playerAmount);
    roundStarter = 0;
    tableCards = new List(this.playerAmount);
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
    currentPlayer++;
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
      /* The first player (human) is set to the trickWinner,
      because no one else has played yet.
      */
      if (playedCards.length == 1) {
        highestCard = playedCards[0];
        trickWinner = players[0];
        print('${trickWinner.name} is leading now');
      }

      foe = playedCards.last;
      setAllowedToPlay(
          player: players[i], wizardIsPlayed: wizardIsPlayed, toServe: toServe);
      gamer.creatingPlayableHandCardsList();
      print('It is the difficulty: $difficulty!');
//      if (i == 1 || i == 4)
      if (difficulty == 2) {
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
      }
//      else if (i == 2 || i == 5)
      else if (difficulty == 0) {
        print('i am Ai');
        aiTookThisCard = players[i].playCard(0, trump: trumpType, foe: foe);
        _playTheCardAiHelper(i);
      }
//      else if (i == 3)
      else if (difficulty == 1) {
        print('i am Ki');
        aiTookThisCard = players[i].playCard(0,
            trump: trumpType,
            foe: foe,
            roundNumber: roundNumber,
            playerNumber: playerAmount,
            alreadyPlayedCards: alreadyPlayedCards,
            highestCard: highestCard);
        _playTheCardAiHelper(i);
      }

      // check if the card is higher then what is played yet
      if (playedCards.length > 1) {
        highestCard = playedCards.last.compare(highestCard, trumpType);
        if (highestCard == playedCards.last) {
          trickWinner = gamer;
          print('${gamer.name} is leading now');
        }
      }

      _nextPlayer();
    } while (trickNotOver);
    trickNotOver = true;
//    trickWinner = players[0];
    print('${trickWinner.name} has won the trick!');
    players[players.indexOf(trickWinner)].tricks++;

    checkEndOfRound();
  }

  /*
  TODO add some description
   */
  bool checkEndOfRound() {
    if (players.last.handCards.length == 0) {
      givePoints();
      players.forEach((gamer) {
        gamer.tricks = 0;
        //This is needed if humanPlayer is not the starter.
//        gamer.lastPlayer = false;
//        gamer.firstPlayer = false;
      });
      betsNumber = 0;
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
//    _nextRoundStarter(); //this is only needed is humanPlayer is not always the starter
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
  This is done in gamepage with _nextTrick
   */
  void endOfGame() {}

  /*
  This method returns the next roundStarter, which is always the player
  next to the last roundStarter. If the last player played (e.g. playerid=5 for
  a five player game) then the roundStarter is set back to 0 (the first player).
   */
  void _nextRoundStarter() {
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

  void putInTheRightPointsInList(int playerByIndex, int newPoints) {
    int oldPoints;
    int inputPoints;
    if (roundNumber > 1) {
      oldPoints = getPointsFromList(playerByIndex, roundNumber - 1);
      inputPoints = oldPoints + newPoints;
    } else {
      inputPoints = newPoints;
    }
    players[playerByIndex].pointsList.add(inputPoints);
  }

  int getPointsFromList(int playerByIndex, int roundNumber) {
    return players[playerByIndex].pointsList[roundNumber - 1];
  }

  void givePoints() {
    int betPredicted;
    int actualTricks;
    int pointsForThisRound = 0;
    for (int i = 0; i < playerAmount; i++) {
      pointsForThisRound = 0;
      betPredicted = getBetFromList(i, roundNumber);
      actualTricks = players[i].tricks;
      if (betPredicted == actualTricks) {
        pointsForThisRound += 20; // for being right
        pointsForThisRound += (10 * actualTricks); // 10 for each trick
      } else {
        // subtract 10 points times the distance between bet and tricks
        pointsForThisRound -= 10 * (actualTricks - betPredicted).abs();
      }
      putInTheRightPointsInList(i, pointsForThisRound);
    }
  }

/*
  This method changes the value of the currentPlayer until the currentPlayer is
  the last player then it will change the value of trickNotOver to false;
   */
  void _nextPlayer() {
    if (currentPlayer == lastPlayer) {
      trickNotOver = false;
      usersChoosenCard = null;
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

  /*
  TODO add some description
   */
  int _whoStarts(int players) {
    return Random().nextInt(players);
  }
}
