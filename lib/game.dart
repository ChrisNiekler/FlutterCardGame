import 'dart:math';
import 'package:wizard2/player.dart';
import 'package:wizard2/round.dart';

// second main is just for backend
void main() {
  int _round = 0;
  int _maxRounds;
  int _playerAmount = 3;
  int dealerID;
  //todo getPlayerNumber()
/*  do {
    print('How many players? (3-6)');
    playerNumber = int.parse(stdin.readLineSync());
  } while (3 > playerNumber || playerNumber > 6);*/
  print('Okay $_playerAmount Players');

  // set _maxRounds to 0 for testing reasons
  _maxRounds = 0;

  //todo implement createPlayers()
  List<Player> players = [
    new Player('uno', 0),
    new Player('dos', 1),
    new Player('tres', 2)
  ];
  dealerID = _whoStarts(_playerAmount);
  do {
    playRound(_round, _maxRounds, players, dealerID++);

    // reset the dealerID when the player with
    // the highest id dealt
    if (!(dealerID < _playerAmount)) {
      dealerID = 0;
    }
  } while (_round < _maxRounds);
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
