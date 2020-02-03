import 'package:wizard/logic/artificial_intelligence/ai.dart';
import 'package:wizard/logic/artificial_intelligence/ki.dart';
import 'package:wizard/logic/artificial_intelligence/kuenstlicheIntelligenz.dart';
import 'package:wizard/logic/humanPlayer.dart';
import 'package:wizard/logic/player.dart';

/*
This class creates the players with the difficulty the humanPlayer has picked.
This is in the backend.
 */
class PlayersUI {}

List<Player> createPlayers(int playerAmount, int difficulty) {
  List<String> names = ['Uno', 'Dos', 'Tres', 'Quadro', 'Sinco', 'Seis'];
  List<Player> players = [];
  for (int i = 0; i < playerAmount; i++) {
    if (i == 0)
      players.add(new HumanPlayer(names[i], i));
    else if (difficulty == 0 && i != 0)
      players.add(new Ai(names[i], i));
    else if (difficulty == 1 && i != 0)
      players.add(new Ki(names[i], i));
    else if (difficulty == 2 && i != 0)
      players.add(new KuenstlicheIntelligenz(names[i], i));
  }
  return players;
}
