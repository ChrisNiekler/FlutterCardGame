import 'dart:math';
import 'package:wizard/logic/card.dart';
import 'package:wizard/logic/cardType.dart';
import 'package:wizard/logic/deck.dart';

abstract class Player {
  String name;
  int id;
  List<Card> handCards = [];
  List<Card> playableHandCards = [];
  int bet = 0;
  int tricks = 0;
  int points = 0;
  bool ai;
  bool lastPlayer = false;
  bool firstPlayer = false;

  Future<Card> playCardFuture();
  void putBet(int roundNumber, int betsNumber,
      {CardType trump,
      String testValue,
      List<Card> alreadyPlayedCards,
      List<Card> playedCards,
      int playerNumber,
      bool firstPlayer});

  Card playCard(int pick,
      {CardType trump,
      Card foe,
      int roundNumber,
      int playerNumber,
      List<Card> alreadyPlayedCards,
      List<Card> playedCards,
      Card highestCard});

//  //done wie kann ich diese methode in round ansprechen, ohne sie auch in humanPlayer implementieren zu müssen???
  //not necessary anymore
//  Card playCardAI(Card foe, Card trump);

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
