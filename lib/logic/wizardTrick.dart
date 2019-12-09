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
