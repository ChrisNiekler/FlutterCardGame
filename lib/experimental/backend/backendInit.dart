import 'dart:math';
import 'package:wizard/logic/artificial_intelligence/ai.dart';
import 'package:wizard/logic/humanPlayer.dart';
import 'package:wizard/logic/artificial_intelligence/ki.dart';
import 'package:wizard/logic/artificial_intelligence/kuenstlicheIntelligenz.dart';
import 'package:wizard/consoleGame/round.dart';
import 'package:wizard/logic/player.dart';

class Backend {
  int _round = 1;
  int _maxRounds;
  int _playerAmount = 6;
  int trickStarter;
  Round currentRound;
  List<int> numberRounds = [0, 0, 0, 20, 15, 12, 10];
  List<String> names = ['Uno', 'Dos', 'Tres', 'Quadro', 'Sinco', 'Seis'];
  List<Player> players;

  Backend(List<Player> players) {
    this.players = players;
    // set _maxRounds to 0 for testing reasons
    _maxRounds = numberRounds[_playerAmount];
    trickStarter = _whoStarts(_playerAmount);
  }
  void newRound() {
    currentRound = new Round(_round, _maxRounds, trickStarter, players);
  }

  void playRound() {
    if (_round <= _maxRounds) {
      currentRound.playRound();
      trickStarter++;
      // reset the trickStarter when the player with
      // the highest id dealt
      if (!(trickStarter < _playerAmount)) {
        trickStarter = 0;
      }
      _round++;
    }
  }
}

/* to determine who starts in the very first round
* take the amount of players and returns a random
* player number */
int _whoStarts(int players) {
  return Random().nextInt(players);
}
