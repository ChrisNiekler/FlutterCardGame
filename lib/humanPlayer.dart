import 'package:wizard/card.dart';
import 'package:wizard/player.dart';
import 'cardType.dart';
import 'dart:io';

class HumanPlayer extends Player {
  @override
  Card playCard(int pick, {CardType trump, Card foe}) {
    Card temp = this.handCards[pick];
    handCards.removeAt(pick);
    return temp;
  }

  // todo test this
  @override
  CardType pickTrumpCard() {
    this.printHandCardsToConsole();
    String input;
    List<String> types = ['club', 'diamond', 'heart', 'spade'];

    print('Please pick the trump');
    do {
      print('Enter "club" (♣), "diamond" (♦), "heart" (♥) or "spade" (♠)' +
          ('\nto do so.'));
      input = stdin.readLineSync();
      input = input.toLowerCase();
    } while (!types.contains(input));
    print('$name pickt $input');
    return CardType.values[types.indexOf(input)];
  }

  HumanPlayer(name, id) {
    this.ai = false;
    this.name = name;
    this.id = id;
  }

  @override
  void putBet(int round, int betsNumber, {CardType trump}) {
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
        } else if (bet < 0) {
          print('Please enter a positive number!');
        } else {
          inputAllowed = true;
        }
      } else {
        print('Please enter a number!');
      }
    } while (!inputAllowed);
    print('$name bet he/she wins $bet tricks!');
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
