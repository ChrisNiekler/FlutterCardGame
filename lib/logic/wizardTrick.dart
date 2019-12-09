import 'package:flutter/cupertino.dart';
import 'package:wizard/logic/card.dart' as logic;
import 'package:wizard/logic/player.dart';
import 'package:wizard/logic/cardType.dart';

List<logic.Card> setAllowedToPlay(
    {@required Player player,
    @required bool wizardIsPlayed,
    @required CardType toServe}) {
  int n = 0;
  // if the toServe Value is NULL there is no card played yet
  List<logic.Card> hand = player.handCards;
  if (toServe == null) {
    hand.forEach(
      (crd) {
        crd.allowedToPlay = true;
        n++;
      },
    );
  } else {
    // else every card in the hand will be compared if it is from type
    // that is required
    hand.forEach(
      (crd) {
        CardType type = crd.cardType;
        if (type == toServe) {
          crd.allowedToPlay = true;
          n++;
        } else if (type == CardType.WIZARD || type == CardType.JESTER) {
          crd.allowedToPlay = true;
        }
      },
    );
  }
  if (n == 0 || wizardIsPlayed) {
    // if no card is from the required type
    // of if a wizard was played
    // any card can be played
    hand.forEach(
      (crd) {
        crd.allowedToPlay = true;
      },
    );
  }
  print('cards are successfully marked as playable or not');
  return hand;
}

CardType determineToServe(
    {@required CardType toServe, @required List<logic.Card> playedCards}) {
  String temp;
  // what to serve
  if (toServe == null) {
// todo put in method
    toServe = playedCards[playedCards.length - 1].cardType;
    temp = CardTypeHelper.getValue(toServe);

    if (toServe == CardType.WIZARD) {
      print('WIZARD was played, everybody else can play any card.');
      toServe = CardType.WIZARD;
    } else if (toServe == CardType.JESTER) {
      print('JESTER was played as first card.');
      print('The next card will determine the played color');
      toServe = null;
    } else {
      print('$temp has to be served!');
    }
    return toServe;
  }
  return null;
}
