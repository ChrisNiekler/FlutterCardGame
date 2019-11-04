import 'package:wizard2/player.dart';
import 'package:wizard2/deck.dart';
import 'package:wizard2/cardTypes.dart';

class Round {
  cardTypes trumpf;
  int roundNumber;
  int dealerID;

  Round(this.trumpf, this.roundNumber, this.dealerID);
  void cardDistribution() {}
  void tricking() {}
  void playCards() {}
  void evaluation() {}
}

void playRound(
    int roundNumber, int maxRounds, List<Player> players, int dealerID) {
  Round currentRound = new Round(cardTypes.JESTER, roundNumber, dealerID);
  print(players.length);
  Deck gameDeck = new Deck();
  gameDeck.printDeckToConsole();
  for (int i = 0; i < 50; i++) {
    gameDeck.takeCard();
    print('');
  }
  gameDeck.printDeckToConsole();
}
