import 'dart:io';
import 'package:wizard2/card.dart';
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

  Card testCard = new Card(cardTypes.SPADE, 4);
  print(testCard.card);
  Card testCard2 = new Card(cardTypes.DIAMOND, 5);
  print(testCard2.card);
  Card testCard3 = new Card(cardTypes.HEART, 6);
  print(testCard3.card);
  Card testCard4 = new Card(cardTypes.CLUB, 7);
  print(testCard4.card);
  Card testCard5 = new Card(cardTypes.WIZARD, 14);
  print(testCard5.card);
  Card testCard6 = new Card(cardTypes.JESTER, 0);
  print(testCard6.card);
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
