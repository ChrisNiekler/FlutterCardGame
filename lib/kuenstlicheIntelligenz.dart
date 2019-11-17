import 'package:wizard/player.dart';
import 'package:wizard/card.dart';
import 'package:wizard/cardType.dart';
import 'dart:math' show Random;
import 'package:wizard/deck.dart';

//todo Tests für KI
//todo anzahl der karten in der runde mit berücksichtigen

class KuenstlicheIntelligenz extends Player {
  KuenstlicheIntelligenz(name, id) {
    this.ai = true;
    this.name = name;
    this.id = id;
  }

  @override
  Card playCard(int pick,
      {CardType trump,
      Card foe,
      int roundNumber,
      int playerNumber,
      List<Card> alreadyPlayedCards,
      List<Card> playedCards}) {
    //1. here it is chosen between all handcards
    if (trump == null) {
      //todo improve (when there is no trump)
      Card temp = findBestCard();
      handCards.remove(temp);
      return temp;
    } else if (foe == null) {
      //todo if no card is played yet (improve this)
      //2. here it is chosen between all playable handcards
      pick = Random().nextInt(playableHandCards.length);
      return handCards.removeAt(pick);
    } else {
      return playCardAI(foe, trump, roundNumber, playerNumber,
          alreadyPlayedCards, playedCards);
    }
  }

  Card playCardAI(Card foe, CardType trump, int roundNumber, int playerNumber,
      List<Card> alreadyPlayedCards, List<Card> playedCards) {
    Card bestCard = findBestCard();
    Card worstCard = findWorstCard();
    if (bestCard == bestCard.compare(foe, trump) &&
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

  //karte legen
  //todo DONE erste KI mit random oder erster Karte
  //todo DONE zweite KI mit erster (oder random) legbarer Karte
  //todo DONE dritte KI mit bester legbarer Karte

  //todo Wahrscheinlichkeitsberechnung für Gewinn des Stichs
  //todo vierte KI beste legbare Kartodote, wenn Wahrscheinlichkeit für Stich größer 0,75
  //todo fünfte KI beste legbare Karte, wenn hohe Wahrscheinlichkeit für Stich und auch überhaupt noch ein Stich benötigt
  //hohe Wahrscheinlichkeit: abhängig von noch vorhanden Karten, der anderen Spieler

  @override
  void putBet(int round, int betsNumber,
      {CardType trump,
      String testValue,
      List<Card> alreadyPlayedCards,
      List<Card> playedCards}) {
    int check;
    this.bet =
        _getWahrscheinlichkeitBet(trump, alreadyPlayedCards, playedCards);
    check = bet + betsNumber;
    if (this.lastPlayer && check == round) {
      if (bet == 0)
        bet++;
      else
        bet--;
    }
    print('$name bet he/she wins $bet tricks!');
  }

  //wetten
  //todo DONE erste bet erstmal immer 1
  //todo DONE zweite bet alle Karten größer gleich 10 ist Anzahl der bet -> wenn nicht möglich zu legen auf Grund der Logik, dann eine weniger wetten

  //todo Wahrscheinlichkeitsberechnung für bessere Karten, als alle Anderen
  //todo an Hand der Wahrscheinlichkeit die dritte bet

  Card findBestCard() {
    //todo maybe check if there is a check with trump and not trump needed
    Card bestCard = this.playableHandCards[0];
    for (int i = 1; i < playableHandCards.length; i++) {
      if (bestCard.value < playableHandCards[i].value)
        bestCard = playableHandCards[i];
    }
    return bestCard;
  }

  Card findWorstCard() {
    //todo maybe check if there is a check with trump and not trump needed
    Card worstCard = this.playableHandCards[0];
    for (int i = 1; i < playableHandCards.length; i++) {
      if (worstCard.value > playableHandCards[i].value)
        worstCard = playableHandCards[i];
    }
    return worstCard;
  }

  int _getWahrscheinlichkeitBet(
      CardType trump, List<Card> alreadyPlayedCards, List<Card> playedCards) {
    int x = 0;
    double check = 0;
    int numberOfPossibleBetterCards = 0;
    int trumpNumber = 0;
    int wizardNumber = 0;
    int betterTrumpNumber = 0;
    int betterCardsOfSameType = 0;
    Deck aiGameDeck = new Deck();
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
        check += numberOfPossibleBetterCards;
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
      if (check <= 0.25) x++;
    }
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
    Deck aiGameDeck = new Deck();
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

    for (int i = 0; i < playableHandCards.length; i++) {
      if (foe.cardType == CardType.WIZARD)
        check++;
      else if (playableHandCards[i].cardType == CardType.WIZARD) {
        check += numberOfPossibleBetterCards;
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
      if (check <= 0.15) tryWinning = true;
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
//todo if wizard is trump (pick trump)
}
