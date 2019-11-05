import 'dart:math';
import 'package:wizard2/humanPlayer.dart';
import 'package:wizard2/round.dart';
import 'package:wizard2/Player.dart';

// second main is just for backend
void main() {
  int _round = 5;
  int _maxRounds;
  int _playerAmount = 4;
  int dealerID;
  Round currentRound;
  //todo getPlayerNumber()
/*  do {
    print('How many players? (3-6)');
    playerNumber = int.parse(stdin.readLineSync());
  } while (3 > playerNumber || playerNumber > 6);*/

  // set _maxRounds to 0 for testing reasons
  _maxRounds = 5;

  //todo implement createPlayers()
  List<HumanPlayer> players = [
    new HumanPlayer('Uno', 0),
    new HumanPlayer('Dos', 1),
    new HumanPlayer('Tres', 2),
    new HumanPlayer('Quadro', 3)
  ];
  dealerID = _whoStarts(_playerAmount);
  do {
    print('$_playerAmount Players');
    print('Round $_round starts!');
    currentRound = new Round(_round, _maxRounds, dealerID, players);
    currentRound.playRound();

    // reset the dealerID when the player with
    // the highest id dealt
    if (!(dealerID < _playerAmount)) {
      dealerID = 0;
    }
  } while (_round < _maxRounds);
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
