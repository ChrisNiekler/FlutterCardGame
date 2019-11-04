import 'dart:io';
import 'package:wizard2/card.dart';
import 'package:wizard2/deck.dart';
import 'package:wizard2/types.dart';

// second main is just for backend
void main() {
  int round = 1;
  int playerNumber = 3;
/*  do {
    print('How many players? (3-6)');
    playerNumber = int.parse(stdin.readLineSync());
  } while (3 > playerNumber || playerNumber > 6);*/
  print('Okay $playerNumber Players');
  Deck gameDeck = new Deck();
  gameDeck.printDeckToConsole();
  print('the end!');
}

void startGame() {}
void exitGame() {}
void gameEnd() {}

class PointsTable {
  List<int> points;
  getPoints() {}
  writePoints() {}
}
