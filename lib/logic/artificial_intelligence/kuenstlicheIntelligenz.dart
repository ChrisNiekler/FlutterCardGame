import 'package:wizard/logic/player.dart';
import 'package:wizard/logic/gamecard.dart';
import 'package:wizard/logic/cardType.dart';
import 'dart:math' show Random;
import 'package:wizard/logic/deck.dart';

//todo Tests für KuenstlicheIntelligenz
//There has not been done a lot of tests for this ai.

/*
This class is the smartest ai of all.
It is playing cards an putting bets with probabilities.
For example:
If there is a high probability to win a trick the ai tries to win.
If there is a high probability to win a lot of tricks it bets a high number.
 */
class KuenstlicheIntelligenz extends Player {
  KuenstlicheIntelligenz(name, id) {
    this.ai = true;
    this.name = name;
    this.id = id;
  }

  Deck aiGameDeck = new Deck();

  /*
  This method picks a trump card for the ai if there is none.
   */
  @override
  CardType pickTrumpCard({String testValue}) {
    CardType trumpType;
    String type;
    int counterWiz = 0,
        counterHeart = 0,
        counterClub = 0,
        counterSpade = 0,
        counterDiamond = 0,
        counterJes = 0;

    if (handCards.length != null) {
      for (int i = 0; i < handCards.length; i++) {
        if (handCards[i].cardType == CardType.JESTER)
          counterJes++;
        else if (handCards[i].cardType == CardType.WIZARD)
          counterWiz++;
        else if (handCards[i].cardType == CardType.HEART)
          counterHeart++;
        else if (handCards[i].cardType == CardType.CLUB)
          counterClub++;
        else if (handCards[i].cardType == CardType.DIAMOND)
          counterDiamond++;
        else if (handCards[i].cardType == CardType.SPADE) counterSpade++;
      }
      if (counterHeart > counterClub &&
          counterHeart > counterSpade &&
          counterHeart > counterDiamond) {
        trumpType = CardType.HEART;
        type = trumpType
            .toString()
            .substring(trumpType.toString().indexOf('.') + 1);
      } else if (counterClub > counterSpade && counterClub > counterDiamond) {
        trumpType = CardType.CLUB;
        type = trumpType
            .toString()
            .substring(trumpType.toString().indexOf('.') + 1);
      } else if (counterSpade > counterDiamond) {
        trumpType = CardType.SPADE;
        type = trumpType
            .toString()
            .substring(trumpType.toString().indexOf('.') + 1);
      } else if (counterDiamond != 0) {
        trumpType = CardType.DIAMOND;
        type = trumpType
            .toString()
            .substring(trumpType.toString().indexOf('.') + 1);
      } else if (counterWiz != 0 || counterJes != 0) {
        trumpType = CardType.values[Random().nextInt(4)];
        type = trumpType
            .toString()
            .substring(trumpType.toString().indexOf('.') + 1);
      }
    }
    print('$name picked $type');
    return trumpType;
  }

  /*
  This method plays a card if there is no trump in the round or no card played
  yet. If both of these are not true, the ai will call its method _playCardAi().
   */
  @override
  GameCard playCard(int pick,
      {CardType trump,
      GameCard foe,
      int roundNumber,
      int playerNumber,
      List<GameCard> alreadyPlayedCards,
      List<GameCard> playedCards,
      GameCard highestCard}) {
    //1. here it is chosen between all handcards
    if (trump == null) {
      //todo improve (when there is no trump)
      GameCard temp = findBestCard(trump);
      // The next line only needed for the console game.
//      handCards.remove(temp);
      return temp;
    } else if (foe == null) {
      GameCard temp = findBestCardWithoutFoe(
          trump, roundNumber, playerNumber, alreadyPlayedCards);
      // The next line only needed for the console game.
//      handCards.remove(temp);
      return temp;
    } else {
      return _playCardAI(foe, trump, roundNumber, playerNumber,
          alreadyPlayedCards, playedCards, highestCard);
    }
  }

  /*
  This is the special play card for the ai when an other player has
  played a card and a trump is set for the round.
   */
  GameCard _playCardAI(
      GameCard foe,
      CardType trump,
      int roundNumber,
      int playerNumber,
      List<GameCard> alreadyPlayedCards,
      List<GameCard> playedCards,
      GameCard highestCard) {
    GameCard bestCard = findBestCard(trump);
    GameCard worstCard = findWorstCard(trump);
    if (bestCard == bestCard.compare(highestCard, trump) &&
        tricks < bet &&
        foe.cardType != CardType.WIZARD &&
        _getWahrscheinlichkeitPlay(
            foe, trump, alreadyPlayedCards, playedCards)) {
      GameCard temp = bestCard;
      // The next line only needed for the console game.
//      handCards.remove(bestCard);
      return temp;
    } else {
      GameCard temp = worstCard;
      // The next line only needed for the console game.
//      handCards.remove(worstCard);
      return temp;
    }
  }

  /*
  This method is putting a bet for the ai.
   */
  @override
  void putBet(int round, int betsNumber,
      {CardType trump,
      String testValue,
      List<GameCard> alreadyPlayedCards,
      List<GameCard> playedCards,
      int playerNumber,
      bool firstPlayer}) {
    int check = 0;
    this.bet = _getWahrscheinlichkeitBet(round, trump, alreadyPlayedCards,
        playedCards, playerNumber, firstPlayer);
    check = bet + betsNumber;
    if (this.lastPlayer && check == round) {
      if (bet == 0)
        bet++;
      else
        bet--;
    }
    print('$name bet he/she wins $bet tricks!');
  }

  /*
  This method finds the bets card in the playable handcards.
   */
  GameCard findBestCard(CardType trump) {
    GameCard bestCard = this.playableHandCards[0];
    for (int i = 1; i < playableHandCards.length; i++) {
      if (playableHandCards[i] == playableHandCards[i].compare(bestCard, trump))
        bestCard = playableHandCards[i];
    }
    return bestCard;
  }

  /*
  This method finds the worst card in the playable handcards.
   */
  GameCard findWorstCard(CardType trump) {
    GameCard worstCard = this.playableHandCards[0];
    for (int i = 1; i < playableHandCards.length; i++) {
      if (worstCard.cardType == trump &&
              playableHandCards[i].cardType != trump ||
          worstCard.cardType == CardType.WIZARD &&
              playableHandCards[i].cardType != CardType.WIZARD ||
          trump != playableHandCards[i].cardType &&
              worstCard.value > playableHandCards[i].value ||
          playableHandCards[i].cardType == CardType.JESTER)
        worstCard = playableHandCards[i];
    }
    return worstCard;
  }

  /*
  This method returns the number how many bets the ai should bet.
   */
  int _getWahrscheinlichkeitBet(
      int roundNumber,
      CardType trump,
      List<GameCard> alreadyPlayedCards,
      List<GameCard> playedCards,
      int playerNumber,
      bool firstPlayer) {
    int x = 0;
    double check = 0;
    int numberOfPossibleBetterCards = 0;
    int trumpNumber = 0;
    int wizardNumber = 0;
    int betterTrumpNumber = 0;
    int betterCardsOfSameType = 0;
    int betterCards = 0;
    int gesamtAnzahl = aiGameDeck.size();

    aiGameDeck =
        _removeCardsFromAiDeck(aiGameDeck, alreadyPlayedCards, playedCards);

    for (int i = 0; i < aiGameDeck.size(); i++) {
      if (aiGameDeck.aiShowCard(i).cardType == CardType.WIZARD)
        wizardNumber++;
      else if (aiGameDeck.aiShowCard(i).cardType == CardType.SPADE &&
          trump == CardType.SPADE)
        trumpNumber++;
      else if (aiGameDeck.aiShowCard(i).cardType == CardType.CLUB &&
          trump == CardType.CLUB)
        trumpNumber++;
      else if (aiGameDeck.aiShowCard(i).cardType == CardType.HEART &&
          trump == CardType.HEART)
        trumpNumber++;
      else if (aiGameDeck.aiShowCard(i).cardType == CardType.DIAMOND &&
          trump == CardType.DIAMOND) trumpNumber++;
    }

    for (int i = 0; i < handCards.length; i++) {
      if (handCards[i].cardType == CardType.WIZARD) {
        numberOfPossibleBetterCards = 0;
      } else if (trump == null) {
        if (handCards[i].value < 11 && !firstPlayer ||
            handCards[i].value < 8 && firstPlayer) betterCards++;
        numberOfPossibleBetterCards = wizardNumber + betterCards;
      } else if (handCards[i].cardType == trump) {
        for (int x = 0; x < aiGameDeck.size(); x++) {
          if (handCards[i].cardType == aiGameDeck.aiShowCard(x).cardType &&
              handCards[i].value < aiGameDeck.aiShowCard(x).value)
            betterTrumpNumber++;
        }
        numberOfPossibleBetterCards = wizardNumber + betterTrumpNumber;
      } else if (handCards[i].cardType != trump) {
        for (int x = 0; x < aiGameDeck.size(); x++) {
          if (handCards[i].cardType == aiGameDeck.aiShowCard(x).cardType &&
              handCards[i].value < aiGameDeck.aiShowCard(x).value)
            betterCardsOfSameType++;
        }
        numberOfPossibleBetterCards =
            trumpNumber + wizardNumber + betterCardsOfSameType;
      }
      gesamtAnzahl = aiGameDeck.size();
      check = numberOfPossibleBetterCards / gesamtAnzahl;
      if (check <= 0.19) x++;
    }
    return x;
  }

  /*
  This method returns a boolean which says if the ai should try to win
  the trick or if the ai should not.
   */
  bool _getWahrscheinlichkeitPlay(GameCard foe, CardType trump,
      List<GameCard> alreadyPlayedCards, List<GameCard> playedCards) {
    bool tryWinning = false;
    double check = 0;
    int numberOfPossibleBetterCards = 0;
    int trumpNumber = 0;
    int wizardNumber = 0;
    int betterTrumpNumber = 0;
    int betterCardsOfSameType = 0;
    int betterCardsOfOtherType = 0;
    int gesamtAnzahl = aiGameDeck.size();
    bool enemyWizard = false;

    aiGameDeck =
        _removeCardsFromAiDeck(aiGameDeck, alreadyPlayedCards, playedCards);

    for (int i = 0; i < aiGameDeck.size(); i++) {
      if (aiGameDeck.aiShowCard(i).cardType == CardType.WIZARD)
        wizardNumber++;
      else if (aiGameDeck.aiShowCard(i).cardType == CardType.SPADE &&
          trump == CardType.SPADE)
        trumpNumber++;
      else if (aiGameDeck.aiShowCard(i).cardType == CardType.CLUB &&
          trump == CardType.CLUB)
        trumpNumber++;
      else if (aiGameDeck.aiShowCard(i).cardType == CardType.HEART &&
          trump == CardType.HEART)
        trumpNumber++;
      else if (aiGameDeck.aiShowCard(i).cardType == CardType.DIAMOND &&
          trump == CardType.DIAMOND) trumpNumber++;
    }

    for (int i = 0; i < playableHandCards.length; i++) {
      if (foe.cardType == CardType.WIZARD)
        enemyWizard = true;
      else if (playableHandCards[i].cardType == CardType.WIZARD) {
        numberOfPossibleBetterCards = 0;
      } else if (playableHandCards[i].cardType == trump) {
        for (int x = 0; x < aiGameDeck.size(); x++) {
          if (playableHandCards[i].cardType ==
                  aiGameDeck.aiShowCard(x).cardType &&
              playableHandCards[i].value < aiGameDeck.aiShowCard(x).value)
            betterTrumpNumber++;
        }
        numberOfPossibleBetterCards = wizardNumber + betterTrumpNumber;
      } else if (playableHandCards[i].cardType != trump) {
        for (int x = 0; x < aiGameDeck.size(); x++) {
          if (playableHandCards[i].cardType ==
                  aiGameDeck.aiShowCard(x).cardType &&
              playableHandCards[i].value < aiGameDeck.aiShowCard(x).value)
            betterCardsOfSameType++;
        }
        if (foe == null) {
          numberOfPossibleBetterCards =
              trumpNumber + wizardNumber + betterCardsOfSameType;
        } else {
          for (int x = 0; x < aiGameDeck.size(); x++) {
            if (foe.cardType == aiGameDeck.aiShowCard(x).cardType)
              betterCardsOfOtherType++;
          }
          if (foe.cardType == playableHandCards[i].cardType) {
            numberOfPossibleBetterCards =
                trumpNumber + wizardNumber + betterCardsOfSameType;
          } else {
            numberOfPossibleBetterCards = trumpNumber +
                wizardNumber +
                betterCardsOfSameType +
                betterCardsOfOtherType;
          }
        }
      }
      check = numberOfPossibleBetterCards / gesamtAnzahl;
      if (check <= 0.15 && !enemyWizard) tryWinning = true;
    }
    return tryWinning;
  }

  /*
  This method removes cards from a separate ai deck.
  With the help of this deck the ai is predicting its chances to win a trick.
   */
  Deck _removeCardsFromAiDeck(Deck aiGameDeck,
      List<GameCard> alreadyPlayedCards, List<GameCard> playedCards) {
    for (int x = 0; x < aiGameDeck.size(); x++) {
      if (alreadyPlayedCards != null) {
        for (int y = 0; y < alreadyPlayedCards.length; y++) {
          if (alreadyPlayedCards[y] == aiGameDeck.aiShowCard(x))
            aiGameDeck.aiRemoveCard(x);
        }
      }
      if (playedCards != null) {
        for (int y = 0; y < playedCards.length; y++) {
          if (playedCards[y] == aiGameDeck.aiShowCard(x))
            aiGameDeck.aiRemoveCard(x);
        }
      }
      if (handCards != null) {
        for (int y = 0; y < handCards.length; y++) {
          if (handCards[y] == aiGameDeck.aiShowCard(x))
            aiGameDeck.aiRemoveCard(x);
        }
      }
    }
    return aiGameDeck;
  }

  /*
  This method finds the best card of the hand of the ai when there is no card
  played yet.
   */
  GameCard findBestCardWithoutFoe(CardType trump, int roundNumber,
      int playerNumber, List<GameCard> alreadyPlayedCards) {
    GameCard temp = playableHandCards[0];
    for (int i = 1; i < playableHandCards.length; i++) {
      if (temp.cardType != trump && playableHandCards[i].cardType == trump ||
          temp.value < playableHandCards[i].value) temp = playableHandCards[i];
    }
    return temp;
  }

  /*
  This method is not used yet.
   */
  @override
  Future<GameCard> playCardFuture() {
    // TODO: implement playCardFuture
    return null;
  }
}
