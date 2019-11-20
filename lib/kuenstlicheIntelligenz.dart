import 'package:wizard/player.dart';
import 'package:wizard/card.dart';
import 'package:wizard/cardType.dart';
import 'dart:math' show Random;
import 'package:wizard/deck.dart';

//todo Tests für KuenstlicheIntelligenz

//todo anzahl der karten in der runde mit berücksichtigen

//todo fehler wenn wizard gespielt ist dass ki obwohl andere karten vorhanden immernoch wizard spielt

class KuenstlicheIntelligenz extends Player {
  KuenstlicheIntelligenz(name, id) {
    this.ai = true;
    this.name = name;
    this.id = id;
  }

  Deck aiGameDeck = new Deck();

  @override
  CardType pickTrumpCard({String testValue}) {
    //todo improve this
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

  @override
  Card playCard(int pick,
      {CardType trump,
      Card foe,
      int roundNumber,
      int playerNumber,
      List<Card> alreadyPlayedCards,
      List<Card> playedCards, Card highestCard}) {
    //1. here it is chosen between all handcards
    if (trump == null) {
      //todo improve (when there is no trump)
      Card temp = findBestCard(trump);
      handCards.remove(temp);
      return temp;
    } else if (foe == null) {
      //todo if no card is played yet (improve this)
      //2. here it is chosen between all playable handcards
      pick = Random().nextInt(playableHandCards.length);
      return handCards.removeAt(pick);
    } else {
      return _playCardAI(foe, trump, roundNumber, playerNumber,
          alreadyPlayedCards, playedCards, highestCard);
    }
  }

  Card _playCardAI(Card foe, CardType trump, int roundNumber, int playerNumber,
      List<Card> alreadyPlayedCards, List<Card> playedCards, Card highestCard) {
    Card bestCard = findBestCard(trump);
    Card worstCard = findWorstCard(trump);
    if (bestCard == bestCard.compare(highestCard, trump) &&
        tricks < bet &&
        foe.cardType != CardType.WIZARD &&
        _getWahrscheinlichkeitPlay(
            foe, trump, alreadyPlayedCards, playedCards)) {
      Card temp = bestCard;
      handCards.remove(bestCard);
      return temp;
    } else {
      Card temp = worstCard;
      handCards.remove(worstCard);
      return temp;
    }
  }

  @override
  void putBet(int round, int betsNumber,
      {CardType trump,
      String testValue,
      List<Card> alreadyPlayedCards,
      List<Card> playedCards, int playerNumber}) {
    int check = 0;
    this.bet =
        _getWahrscheinlichkeitBet(round, trump, alreadyPlayedCards, playedCards, playerNumber);
    check = bet + betsNumber;
    if (this.lastPlayer && check == round) {
      if (bet == 0)
        bet++;
      else
        bet--;
    }
    print('$name bet he/she wins $bet tricks!');
  }

  Card findBestCard(CardType trump) {
    //todo maybe check if there is a check with trump and not trump needed
    Card bestCard = this.playableHandCards[0];
    for (int i = 1; i < playableHandCards.length; i++) {
      if (playableHandCards[i] == playableHandCards[i].compare(bestCard, trump))
        bestCard = playableHandCards[i];
    }
    return bestCard;
  }

  Card findWorstCard(CardType trump) {
    //todo maybe check if there is a check with trump and not trump needed
    Card worstCard = this.playableHandCards[0];
    for (int i = 1; i < playableHandCards.length; i++) {
      if (playableHandCards[i] !=
          playableHandCards[i].compare(worstCard, trump))
        worstCard = playableHandCards[i];
    }
    return worstCard;
  }

  int _getWahrscheinlichkeitBet(int roundNumber,
      CardType trump, List<Card> alreadyPlayedCards, List<Card> playedCards, playerNumber) {
    int x = 0;
    double check = 0;
    int numberOfPossibleBetterCards = 0;
    int trumpNumber = 0;
    int wizardNumber = 0;
    int betterTrumpNumber = 0;
    int betterCardsOfSameType = 0;
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
      if (check <= 0.20) x++;

    }
    //todo try if it works somehow else
//    int lengthOfAIDeck = aiGameDeck.size() - (playerNumber * roundNumber);
//    int cardsOnEnemyHands = roundNumber * (playerNumber - 1);
//    int help2 = lengthOfAIDeck - numberOfPossibleBetterCards;
//    double help =
//        (_binominalkoeffizient(numberOfPossibleBetterCards, 0) *
//        _binominalkoeffizient(help2, cardsOnEnemyHands)) /
//        _binominalkoeffizient(lengthOfAIDeck, cardsOnEnemyHands);
//    x = (help * roundNumber).toInt();
    return x;
  }

  bool _getWahrscheinlichkeitPlay(Card foe, CardType trump,
      List<Card> alreadyPlayedCards, List<Card> playedCards) {
    bool tryWinning = false;
    int x = 0;
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

  Deck _removeCardsFromAiDeck(
      Deck aiGameDeck, List<Card> alreadyPlayedCards, List<Card> playedCards) {
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

  double _binominalkoeffizient (int n, int k) {
    double s = 0;
    if (k < n) {
      s = _fakultaet(n) / _fakultaet(n-k);
    }
    return s;
  }

  double _fakultaet (int x) {
    double s = 0;
    if (x > 0 && x != 1)
    {
      s = 1;
      do {
        s = s * x;
        x--;
      } while (x > 1);
      return s;
    }
  }
}
