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
  void putBet() {
    this.bet = 1;
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
