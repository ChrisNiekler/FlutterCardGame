import 'package:wizard2/card.dart';
import 'package:wizard2/player.dart';
import 'cardTypes.dart';
import 'dart:io';

class HumanPlayer extends Player {
  @override
  Card playCard(int pick, {cardTypes trump, Card foe}) {
    Card temp = this.handCards[pick];
    handCards.removeAt(pick);
    return temp;
  }

  HumanPlayer(name, id) {
    this.ai = false;
    this.name = name;
    this.id = id;
  }

  @override
  void putBet(int round, int betsNumber, {cardTypes trump}) {
    bool inputAllowed = false;
    String inputString = '';
    int check;
    this.printHandCardsToConsole();
    do {
      print('Put your bet:');
      inputString = stdin.readLineSync();
      if (_isNumeric(inputString)) {
        this.bet = int.parse(inputString);
        check = bet + betsNumber;
        if (this.lastPlayer && round == check) {
          print(
              'Please take another number, because the bets have to differ the possible tricks!');
        } else
          inputAllowed = true;
      } else
        print('Please put a number!');
    } while (!inputAllowed);
    print('$name bet he/she wins $bet tricks!');
  }

  @override
  int getBetsNumber() {
    return bet;
  }

  Card humanPlayCard() {
    bool inputAllowed = false;
    String input = '';
    int size;
    int cardNr = -1;
    size = this.handCards.length;

    this.printHandCardsToConsole();
    do {
      print('Please pick one of your $size cards (by index) to play: ');
      input = stdin.readLineSync();
      if (_isNumeric(input)) {
        cardNr = int.parse(input);
      }
      if (cardNr >= 0 && cardNr < size) {
        if (this.handCards[cardNr].allowedToPlay) {
          inputAllowed = true;
        } else {
          print('Please pick another card!');
        }
      }
    } while (!inputAllowed);
    return this.playCard(cardNr);
  }
}

bool _isNumeric(String str) {
  if (str == null) {
    return false;
  }
  return int.tryParse(str) != null;
}
