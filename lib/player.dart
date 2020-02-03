import 'dart:math';
import 'package:wizard/card.dart';
import 'package:wizard/cardType.dart';
import 'package:wizard/deck.dart';

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

  void putBet(int roundNumber, int betsNumber,
      {CardType trump, String testValue});

  Card playCard(int pick, {CardType trump, Card foe});


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
          print('[$index][-] ' + temp);
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

  CardType pickTrumpCard({String testValue}) {
    CardType trumpType;
    String type;

    trumpType = CardType.values[Random().nextInt(4)];
    type =
        trumpType.toString().substring(trumpType.toString().indexOf('.') + 1);
    print('$name pickt $type (yet random)');
    return trumpType;
  }

  void printPoints() {
    print('$name has $points points.');
  }
}
