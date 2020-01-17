import 'dart:math';
import 'package:wizard/logic/gamecard.dart';
import 'package:wizard/logic/cardType.dart';
import 'package:wizard/logic/deck.dart';

abstract class Player {
  String name;
  int id;
  List<GameCard> handCards = [];
  List<GameCard> playableHandCards = [];
  int bet;
  List<int> betsList = [];
  List<int> pointsList = [];
  int tricks = 0;
  int points = 0;
  bool ai;
  bool lastPlayer = false;
  bool firstPlayer = false;

  Future<GameCard> playCardFuture();
  void putBet(int roundNumber, int betsNumber,
      {CardType trump,
      String testValue,
      List<GameCard> alreadyPlayedCards,
      List<GameCard> playedCards,
      int playerNumber,
      bool firstPlayer});

  GameCard playCard(int pick,
      {CardType trump,
      GameCard foe,
      int roundNumber,
      int playerNumber,
      List<GameCard> alreadyPlayedCards,
      List<GameCard> playedCards,
      GameCard highestCard});

  void addCard(Deck deck) {
    handCards.add(deck.takeCard());
  }

  void printHandCardsToConsole() {
    String temp;
    int index = 0;
    this.handCards.forEach(
      (element) {
        temp = element.card;

        if (element.allowedToPlay) {
          print('[$index][+] ' + temp);
        } else {
          print('[$index][-]' + temp);
        }
        index++;
      },
    );
  }

  void creatingPlayableHandCardsList() {
    this.handCards.forEach((element) {
      if (element.allowedToPlay) {
        playableHandCards.add(element);
      }
    });
  }

  /* override this in  derivatives
      ask the player who deals to pick the card */

  CardType pickTrumpCard({String testValue});

//  {
//    CardType trumpType;
//    String type;
//
//    trumpType = CardType.values[Random().nextInt(4)];
//    type =
//        trumpType.toString().substring(trumpType.toString().indexOf('.') + 1);
//    print('$name pickt $type (yet random)');
//    return trumpType;
//  }

  void printPoints() {
    print('$name has $points points.');
  }
}
