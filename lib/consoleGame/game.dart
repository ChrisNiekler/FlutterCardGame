import 'dart:math';
import 'package:wizard/logic/artificial_intelligence/ai.dart';
import 'package:wizard/logic/humanPlayer.dart';
import 'package:wizard/logic/artificial_intelligence/ki.dart';
import 'package:wizard/logic/artificial_intelligence/kuenstlicheIntelligenz.dart';
import 'package:wizard/consoleGame/round.dart';
import 'package:wizard/logic/player.dart';
import 'dart:io';

/*
This class is only for the console game.
 */
void main() {
  // todo when all are done
  //  put more comments + clean code
  int _round = 1;
  int _maxRounds;
  int _playerAmount = 0;
  int trickStarter;
  Round currentRound;
  List<int> numberRounds = [0, 0, 0, 20, 15, 12, 10];
  List<String> names = ['Uno', 'Dos', 'Tres', 'Quadro', 'Sinco', 'Seis'];
  List<Player> players = [];

  do {
    print('How many players? (3-6)');
    String input = stdin.readLineSync();
    if (_isNumeric(input)) {
      _playerAmount = int.parse(input);
    }
  } while (3 > _playerAmount || _playerAmount > 6);

  // set _maxRounds to 0 for testing reasons
  _maxRounds = numberRounds[_playerAmount];

  //create Players
  for (int i = 0; i < _playerAmount; i++) {
    if (i == 0)
      players.add(new HumanPlayer(names[i], i));
    else if (i == 1)
      players.add(new KuenstlicheIntelligenz(names[i], i));
    else if (i == 2)
      players.add(new Ai(names[i], i));
    else if (i == 3)
      players.add(new Ki(names[i], i));
    else if (i == 4)
      players.add(new KuenstlicheIntelligenz(names[i], i));
    else if (i == 5) players.add(new Ai(names[i], i));
  }

  trickStarter = _whoStarts(_playerAmount);
  String temp = '';
  do {
    print('---------- $_playerAmount Players ----------');
    print('----------- Round $_round -----------');
    print('-------------------------------');
    temp = players[trickStarter].name;
    print('\n$temp will start this round.');
    currentRound = new Round(_round, _maxRounds, trickStarter, players);
    currentRound.playRound();
    trickStarter++;
    // reset the trickStarter when the player with
    // the highest id dealt
    if (!(trickStarter < _playerAmount)) {
      trickStarter = 0;
    }
    _round++;
  } while (_round <= _maxRounds);

  // indicates that the game is over
  print('the end!');

  // TODO : Save result in database
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

bool _isNumeric(String str) {
  if (str == null) {
    return false;
  }
  return int.tryParse(str) != null;
}
