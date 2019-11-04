import 'package:wizard2/player.dart';
import 'package:wizard2/deck.dart';
import 'package:wizard2/cardTypes.dart';

class Round {
  cardTypes trumpf;
  int roundNumber;
  int dealerID;

  Round(this.trumpf, this.roundNumber, this.dealerID);
}

void playRound(
    int roundNumber, int maxRounds, List<Player> players, int dealerID) {
  Round currentRound = new Round(cardTypes.JESTER, roundNumber, dealerID);
  Deck gameDeck = new Deck();
  cardDistribution(players, roundNumber, gameDeck);
  print('\n');
  int cardsInHand = players[0].handCards.length;
  print('cards in hand $cardsInHand');
  players.forEach((element) {
    String n = element.name;
    print('Playername: $n');
    print('Cards in hand!');
    element.printHandCardsToConsole();
    print('\n');
  });
}

void cardDistribution(List<Player> players, int round, Deck deck) {
  int lng = players.length;
  for (int i = 0; i < round; i++) {
    for (int j = 0; j < lng; j++) {
      players[j].handCards.add(deck.takeCard());
    }
  }
}

void tricking() {}
void playCards() {}
void evaluation() {}
