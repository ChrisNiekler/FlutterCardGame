import 'package:flutter/cupertino.dart';
import 'package:wizard/logic/card.dart' as logic;
import 'package:wizard/logic/player.dart';
import 'cardType.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class HumanPlayer extends Player {
  @override
  logic.Card playCard(int pick,
      {CardType trump,
      logic.Card foe,
      int roundNumber,
      int playerNumber,
      List<logic.Card> alreadyPlayedCards,
      List<logic.Card> playedCards,
      logic.Card highestCard}) {
    logic.Card temp = this.handCards[pick];
    handCards.removeAt(pick);
    return temp;
  }

  @override
  CardType pickTrumpCard({String testValue}) {
    this.printHandCardsToConsole();
    String input;
    List<String> types = ['club', 'diamond', 'heart', 'spade'];

    print('Please pick the trump');
    do {
      if (testValue == null) {
        print('Enter "club" (♣), "diamond" (♦), "heart" (♥) or "spade" (♠)' +
            ('\nto do so.'));
        input = stdin.readLineSync();
      } else {
        input = testValue;
      }
      input = input.toLowerCase();
    } while ((!types.contains(input)) && testValue == null);
    print('$name picked $input');

    return CardType.values[types.indexOf(input)];
  }

  HumanPlayer(name, id) {
    this.ai = false;
    this.name = name;
    this.id = id;
  }

  @override
  void putBet(int round, int betsNumber,
      {CardType trump,
      String testValue,
      List<logic.Card> alreadyPlayedCards,
      List<logic.Card> playedCards,
      int playerNumber,
      bool firstPlayer}) {
    bool inputAllowed = false;
    String inputString = '';
    int check;
    this.printHandCardsToConsole();
    do {
      if (testValue != null) {
        inputString = testValue;
      } else {
        print('Put your bet:');
        inputString = stdin.readLineSync();
      }
      if (true) {
        this.bet = int.parse(inputString);
        check = bet + betsNumber;
        if (this.lastPlayer && round == check) {
          print(
              'Please take another number, because the bets have to differ the possible tricks!');
        } else if (bet < 0) {
          print('Please enter a positive number!');
        } else {
          inputAllowed = true;
        }
      } else {
        print('Please enter a number!');
      }
    } while (!inputAllowed && testValue == null);
    print('$name bet he/she wins $bet tricks!');
  }

  logic.Card humanPlayCard({@required logic.Card playedCard}) {
    int index = handCards.indexOf(playedCard);
    logic.Card temp = handCards.elementAt(index);
    print('temp= $temp');
    handCards.removeAt(index);
    if (!handCards.contains(temp)) {
      print('$temp successfully removed');
    }

    return temp;
  }
}
