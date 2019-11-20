import 'package:wizard/player.dart';
import 'package:wizard/card.dart';
import 'package:wizard/cardType.dart';
import 'dart:math' show Random;

//todo Tests für KI

class Ki extends Player {
  Ki(name, id) {
    this.ai = true;
    this.name = name;
    this.id = id;
  }

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
      List<Card> playedCards,
      Card highestCard}) {
    //1. here it is chosen between all handcards
    if (trump == null) {
      //todo improve (when there is no trump)
      Card temp = _findBestCard(trump);
      handCards.remove(temp);
      return temp;
    } else if (foe == null) {
      //todo if no card is played yet (improve this)
      //2. here it is chosen between all playable handcards
      pick = Random().nextInt(playableHandCards.length);
      return handCards.removeAt(pick);
    } else {
      return _playCardAI(foe, trump, highestCard);
    }
  }

  Card _playCardAI(Card foe, CardType trump, Card highestCard) {
    //3. here play best or worst Card -> at the  moment problem caching value of the best played card and the trump
    //todo DONE get more intelligent (Wahrscheinlichkeiten, ...)
    Card bestCard = _findBestCard(trump);
    Card worstCard = _findWorstCard(trump);
    if (bestCard == bestCard.compare(highestCard, trump) &&
        tricks < bet &&
        foe.cardType != CardType.WIZARD) {
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

  //todo DONE Wahrscheinlichkeitsberechnung für Gewinn des Stichs
  //todo DONE vierte KI beste legbare Kartodote, wenn Wahrscheinlichkeit für Stich größer 0,75
  //todo DONE fünfte KI beste legbare Karte, wenn hohe Wahrscheinlichkeit für Stich und auch überhaupt noch ein Stich benötigt
  //hohe Wahrscheinlichkeit: abhängig von noch vorhanden Karten, der anderen Spieler

  @override
  void putBet(int round, int betsNumber,
      {CardType trump,
      String testValue,
      List<Card> alreadyPlayedCards,
      List<Card> playedCards,
      int playerNumber}) {
    int check = 0;
    this.bet = 0;
    for (int i = 0; i < handCards.length; i++) {
      if (handCards[i].cardType == CardType.WIZARD)
        bet++;
      else if (handCards[i].cardType == trump && handCards[i].value > 8)
        bet++;
      else if (handCards[i].value > 11) bet++;
    }
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

  //todo DONE Wahrscheinlichkeitsberechnung für bessere Karten, als alle Anderen
  //todo DONE an Hand der Wahrscheinlichkeit die dritte bet

  Card _findBestCard(trump) {
    Card bestCard = this.playableHandCards[0];
    for (int i = 1; i < playableHandCards.length; i++) {
      if (playableHandCards[i] == playableHandCards[i].compare(bestCard, trump))
        bestCard = playableHandCards[i];
    }
    return bestCard;
  }

  Card _findWorstCard(CardType trump) {
    Card worstCard = this.playableHandCards[0];
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
}
