import 'package:wizard/logic/player.dart';
import 'package:wizard/logic/gamecard.dart';
import 'package:wizard/logic/cardType.dart';
import 'dart:math' show Random;

/*
This is the ai with the medium difficulty.
 */
class Ki extends Player {
  Ki(name, id) {
    this.ai = true;
    this.name = name;
    this.id = id;
  }

  /*
  This method picks the best trumpCard for the ai if there is no trumpCard yet.
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
  This method plays a card to win the trick.
  If there is no trump then the best card is played.
  And if there is no card played yet then the best card is played.
  Else it decides with the method _playCardAi().
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
    if (trump == null) {
      GameCard temp = _findBestCard(trump);
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
      return _playCardAI(foe, trump, highestCard);
    }
  }

  /*
  This method returns the best or worst card. If the player wants to win a trick
  then the best and if he does not want to win then the worst.
   */
  GameCard _playCardAI(GameCard foe, CardType trump, GameCard highestCard) {
    GameCard bestCard = _findBestCard(trump);
    GameCard worstCard = _findWorstCard(trump);
    if (bestCard == bestCard.compare(highestCard, trump) &&
        tricks < bet &&
        foe.cardType != CardType.WIZARD) {
      GameCard temp = bestCard;
//      handCards.remove(bestCard);
      return temp;
    } else {
      GameCard temp = worstCard;
//      handCards.remove(worstCard);
      return temp;
    }
  }

  /*
  This method put the bet number which is the best for the ai.
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

  /*
  This method returns the best card of the possible playable handcards.
   */
  GameCard _findBestCard(trump) {
    GameCard bestCard = this.playableHandCards[0];
    for (int i = 1; i < playableHandCards.length; i++) {
      if (playableHandCards[i] == playableHandCards[i].compare(bestCard, trump))
        bestCard = playableHandCards[i];
    }
    return bestCard;
  }

  /*
  This method returns the worst card of the possible playable handcards.
   */
  GameCard _findWorstCard(CardType trump) {
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
  This method returns the best card of the possible playable handcards
  when there is no card played yet.
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
