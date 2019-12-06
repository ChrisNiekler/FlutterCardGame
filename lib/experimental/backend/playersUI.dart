import 'package:flutter/material.dart';
import 'package:wizard/logic/artificial_intelligence/ai.dart';
import 'package:wizard/logic/artificial_intelligence/ki.dart';
import 'package:wizard/logic/artificial_intelligence/kuenstlicheIntelligenz.dart';
import 'package:wizard/logic/humanPlayer.dart';
import 'package:wizard/logic/player.dart';

class PlayersUI {}

List<Player> createPlayers(int _playerAmount) {
 // int _playerAmount = 6;
  List<String> names = ['Uno', 'Dos', 'Tres', 'Quadro', 'Sinco', 'Seis'];
  List<Player> players = [];
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
  return players;
}
