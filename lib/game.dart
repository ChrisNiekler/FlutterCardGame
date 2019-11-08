import 'dart:math';
import 'package:wizard2/humanPlayer.dart';
import 'package:wizard2/ki.dart';
import 'package:wizard2/round.dart';
import 'package:wizard2/player.dart';

// second main is just for backend
void main() {
  int _round = 4;
  int _maxRounds;
  int _playerAmount = 4;
  int dealerID;
  Round currentRound;
  //todo getPlayerNumber() F4N
/*  do {
    print('How many players? (3-6)');
    playerNumber = int.parse(stdin.readLineSync());
  } while (3 > playerNumber || playerNumber > 6);*/

  // set _maxRounds to 0 for testing reasons
  _maxRounds = 6;

  //todo implement createPlayers() F4N
  List<Player> players = [
    new HumanPlayer('Uno', 0),
    new Ki('Dos', 1),
    new Ki('Tres', 2),
    //new HumanPlayer('Quadro', 3),
    new Ki('Quadro', 3)
  ];
  dealerID = _whoStarts(_playerAmount);
  // dealerID is 0 for testing reasons
  dealerID = 0;
  do {
    print('--- $_playerAmount Players ---');
    print('--- Round $_round ---');
    currentRound = new Round(_round, _maxRounds, dealerID, players);
    currentRound.playRound();

    // reset the dealerID when the player with
    // the highest id dealt
    if (!(dealerID < _playerAmount)) {
      dealerID = 0;
    }
    _round++;
  } while (_round <= _maxRounds);
  // indicates that the game is over
  print('the end!');
}

void startGame() {}
void exitGame() {}
void gameEnd() {}

/* The PointTable is to track the points and to determine
*  the winner in the end */
class PointsTable {
  List<int> points;
  getPoints() {}
  writePoints() {}
}

/* to determine who starts in the very first round
* take the amount of players and returns a random
* player number */
int _whoStarts(int players) {
  return Random().nextInt(players);
}
