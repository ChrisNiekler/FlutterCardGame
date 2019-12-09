import 'dart:async';
import 'package:test/test.dart';
import 'package:wizard/logic/gamecard.dart';
import 'package:wizard/logic/cardType.dart';
import 'package:wizard/logic/deck.dart';
import 'package:wizard/logic/humanPlayer.dart';
import 'package:wizard/logic/artificial_intelligence/ki.dart';
import 'package:wizard/logic/artificial_intelligence/kuenstlicheIntelligenz.dart';

var log = [];

void main() {
  group('ALL:', () {
    group('HumanPlayer:', () {
      group('pickTrumpCard:', () {
        HumanPlayer player = new HumanPlayer('testDummy', 0);
        test('club', () {
          expect(player.pickTrumpCard(testValue: "club"), CardType.CLUB);
        });

        test('heart', () {
          expect(player.pickTrumpCard(testValue: "HEART"), CardType.HEART);
        });

        test('spade', () {
          expect(player.pickTrumpCard(testValue: 'sPade'), CardType.SPADE);
        });

        test('diamond', () {
          expect(player.pickTrumpCard(testValue: 'diamond'), CardType.DIAMOND);
        });
        test('nonsense', () {
          expect(() => player.pickTrumpCard(testValue: 'nonsense'),
              throwsA(TypeMatcher<RangeError>()));
        });
      }); // end pickTrumpCard
      group('putBet:', () {
        HumanPlayer player = new HumanPlayer('testDummy', 0);

        // check general bet
        test('butBet', () {
          //  if we bet 1 , we expect 1 to be our bet
          player.putBet(10, 4, testValue: '1');
          expect(player.bet, 1);
        });

        // check negative bet
        test('negative', overridePrint(() {
          //  if we bet 1 , we expect 1 to be our bet
          player.putBet(10, 4, testValue: '-1');
          expect(log, [
            'Please enter a positive number!',
            'testDummy bet he/she wins -1 tricks!'
          ]);
          log = [];
          player.bet = 0;
        }));
        // check non numeric bet
        test('nonNumeric', overridePrint(() {
          //  if we bet 1 , we expect 1 to be our bet
          player.putBet(10, 4, testValue: 'x');

          expect(log, [
            'Please enter a number!',
            'testDummy bet he/she wins 0 tricks!'
          ]);
          log = [];
        }));
        // check last player puts a wrong bet
        test('lastPlayerBetWrong', overridePrint(() {
          //  the last player can not bet a number that in a sum with the other
          // players bets equals the number of rounds
          player.lastPlayer = true;
          player.putBet(5, 4, testValue: '1');

          expect(log, [
            'Please take another number, because the bets have to differ the possible tricks!',
            'testDummy bet he/she wins 1 tricks!'
          ]);
          log = [];
        }));
      });
    }); // end HumanPlayer

    group('KI:', () {
      group('PickTrumpCard:', () {
        test('club', () {
          Ki ai = new Ki('ki_dummy', 0);
          List<GameCard> deckList = [
            new GameCard(CardType.CLUB, 4),
            new GameCard(CardType.JESTER, 0),
            new GameCard(CardType.HEART, 5),
            new GameCard(CardType.CLUB, 7),
            new GameCard(CardType.DIAMOND, 4)
          ];
          Deck deck = new Deck();
          deck.deck = deckList;
          while (deck.size() > 0) {
            ai.addCard(deck);
          }
          expect(ai.pickTrumpCard(), CardType.CLUB);
        });
        test('spade', () {
          Ki ai = new Ki('ki_dummy', 0);
          List<GameCard> deckList = [
            new GameCard(CardType.SPADE, 4),
            new GameCard(CardType.JESTER, 0),
            new GameCard(CardType.HEART, 5),
            new GameCard(CardType.SPADE, 7),
            new GameCard(CardType.DIAMOND, 4)
          ];
          Deck deck = new Deck();
          deck.deck = deckList;
          while (deck.size() > 0) {
            ai.addCard(deck);
          }
          expect(ai.pickTrumpCard(), CardType.SPADE);
        });
        test('diamond', () {
          Ki ai = new Ki('ki_dummy', 0);
          List<GameCard> deckList = [
            new GameCard(CardType.DIAMOND, 4),
            new GameCard(CardType.JESTER, 0),
            new GameCard(CardType.DIAMOND, 5),
            new GameCard(CardType.CLUB, 7),
            new GameCard(CardType.DIAMOND, 4)
          ];
          Deck deck = new Deck();
          deck.deck = deckList;
          while (deck.size() > 0) {
            ai.addCard(deck);
          }
          expect(ai.pickTrumpCard(), CardType.DIAMOND);
        });
        test('heart', () {
          Ki ai = new Ki('ki_dummy', 0);
          List<GameCard> deckList = [
            new GameCard(CardType.HEART, 4),
            new GameCard(CardType.JESTER, 0),
            new GameCard(CardType.HEART, 5),
            new GameCard(CardType.CLUB, 7),
            new GameCard(CardType.DIAMOND, 4)
          ];
          Deck deck = new Deck();
          deck.deck = deckList;
          while (deck.size() > 0) {
            ai.addCard(deck);
          }
          expect(ai.pickTrumpCard(), CardType.HEART);
        });

        //todo need to test random bei only wiz or jes
      }); //end PickTrumpCard
      group('PlayCard:', () {
        test('play better Card with trumpType', () {
          Ki ai = new Ki('ai_dummy', 0); //ai zum testen
          List<GameCard> deckList = [
            new GameCard(CardType.HEART, 2),
            new GameCard(CardType.JESTER, 0),
            new GameCard(CardType.HEART, 10),
            new GameCard(CardType.CLUB, 7),
            new GameCard(CardType.DIAMOND, 4)
          ];
          for (int i = 0; i < deckList.length; i++) {
            if (CardType.HEART == deckList[i].cardType)
              deckList[i].allowedToPlay = true;
          }
          Deck deck = new Deck();
          deck.deck = deckList;
          while (deck.size() > 0) {
            ai.addCard(deck);
          }
          ai.creatingPlayableHandCardsList();
          List<GameCard> playedCards = [
            new GameCard(CardType.HEART, 6),
            new GameCard(CardType.CLUB, 3)
          ];
          ai.tricks = 0;
          ai.bet = 2;
//          Card actually = new Card(CardType.HEART, 10);
//          expect(ai.playCard(1, trump: CardType.HEART,
//              foe: new Card(CardType.HEART, 6),
//              roundNumber: 5,
//              playerNumber: 3,
//              playedCards: playedCards,
//              highestCard: new Card(CardType.HEART, 6)), actually);
          expect(
              ai
                  .playCard(1,
                      trump: CardType.HEART,
                      foe: new GameCard(CardType.HEART, 6),
                      roundNumber: 5,
                      playerNumber: 3,
                      playedCards: playedCards,
                      highestCard: new GameCard(CardType.HEART, 6))
                  .cardType,
              CardType.HEART);
          expect(
              ai
                  .playCard(1,
                      trump: CardType.HEART,
                      foe: new GameCard(CardType.HEART, 6),
                      roundNumber: 5,
                      playerNumber: 3,
                      playedCards: playedCards,
                      highestCard: new GameCard(CardType.HEART, 6))
                  .value,
              10);
        });
        test('worseCard play jester', () {
          Ki ai = new Ki('ai_dummy', 0); //ai zum testen
          List<GameCard> deckList = [
            new GameCard(CardType.HEART, 2),
            new GameCard(CardType.JESTER, 0),
            new GameCard(CardType.HEART, 10),
            new GameCard(CardType.CLUB, 7),
            new GameCard(CardType.DIAMOND, 4)
          ];
          for (int i = 0; i < deckList.length; i++) {
            if (CardType.HEART == deckList[i].cardType ||
                CardType.JESTER == deckList[i].cardType ||
                CardType.WIZARD == deckList[i].cardType)
              deckList[i].allowedToPlay = true;
          }
          Deck deck = new Deck();
          deck.deck = deckList;
          while (deck.size() > 0) {
            ai.addCard(deck);
          }
          ai.creatingPlayableHandCardsList();
          List<GameCard> playedCards = [
            new GameCard(CardType.HEART, 12),
            new GameCard(CardType.CLUB, 3)
          ];
          ai.tricks = 0;
          ai.bet = 2;
          expect(
              ai
                  .playCard(1,
                      trump: CardType.HEART,
                      foe: new GameCard(CardType.HEART, 12),
                      roundNumber: 5,
                      playerNumber: 3,
                      playedCards: playedCards,
                      highestCard: new GameCard(CardType.HEART, 12))
                  .cardType,
              CardType.JESTER);
          expect(
              ai
                  .playCard(1,
                      trump: CardType.HEART,
                      foe: new GameCard(CardType.HEART, 12),
                      roundNumber: 5,
                      playerNumber: 3,
                      playedCards: playedCards,
                      highestCard: new GameCard(CardType.HEART, 12))
                  .value,
              0);
        });
        test('play worseCard with trumpType', () {
          Ki ai = new Ki('ai_dummy', 0); //ai zum testen
          List<GameCard> deckList = [
            new GameCard(CardType.HEART, 2),
            new GameCard(CardType.SPADE, 8),
            new GameCard(CardType.HEART, 10),
            new GameCard(CardType.CLUB, 7),
            new GameCard(CardType.DIAMOND, 4)
          ];
          for (int i = 0; i < deckList.length; i++) {
            if (CardType.HEART == deckList[i].cardType ||
                CardType.JESTER == deckList[i].cardType ||
                CardType.WIZARD == deckList[i].cardType)
              deckList[i].allowedToPlay = true;
          }
          Deck deck = new Deck();
          deck.deck = deckList;
          while (deck.size() > 0) {
            ai.addCard(deck);
          }
          ai.creatingPlayableHandCardsList();
          List<GameCard> playedCards = [
            new GameCard(CardType.HEART, 12),
            new GameCard(CardType.CLUB, 3)
          ];
          ai.tricks = 0;
          ai.bet = 2;
          expect(
              ai
                  .playCard(1,
                      trump: CardType.HEART,
                      foe: new GameCard(CardType.HEART, 12),
                      roundNumber: 5,
                      playerNumber: 3,
                      playedCards: playedCards,
                      highestCard: new GameCard(CardType.HEART, 12))
                  .cardType,
              CardType.HEART);
          expect(
              ai
                  .playCard(1,
                      trump: CardType.HEART,
                      foe: new GameCard(CardType.HEART, 12),
                      roundNumber: 5,
                      playerNumber: 3,
                      playedCards: playedCards,
                      highestCard: new GameCard(CardType.HEART, 12))
                  .value,
              2);
        });
        //todo this is not doing it yet
        //fehler in findworstCArd
//        test('play worseCard without trumpType', () {
//          Ki ai = new Ki('ai_dummy', 0);
//          List<Card> deckList = [
//            new Card(CardType.CLUB, 2),
//            new Card(CardType.SPADE, 8),
//            new Card(CardType.DIAMOND, 10),
//            new Card(CardType.CLUB, 7),
//            new Card(CardType.DIAMOND, 4)
//          ];
//          for (int i = 0; i < deckList.length; i++) {
//              deckList[i].allowedToPlay = true;
//          }
//          Deck deck = new Deck();
//          deck.deck = deckList;
//          while (deck.size() > 0) {
//            ai.addCard(deck);
//          }
//          ai.creatingPlayableHandCardsList();
//          List<Card> playedCards = [
//            new Card(CardType.HEART, 12),
//            new Card(CardType.CLUB, 3)
//          ];
//          ai.tricks = 0;
//          ai.bet = 2;
////          expect(
////              ai
////                  .playCard(1,
////                  trump: CardType.HEART,
////                  foe: new Card(CardType.HEART, 12),
////                  roundNumber: 5,
////                  playerNumber: 3,
////                  playedCards: playedCards,
////                  highestCard: new Card(CardType.HEART, 12))
////                  .cardType,
////              CardType.CLUB);
//          expect(
//              ai
//                  .playCard(1,
//                  trump: CardType.HEART,
//                  foe: new Card(CardType.HEART, 12),
//                  roundNumber: 5,
//                  playerNumber: 3,
//                  playedCards: playedCards,
//                  highestCard: new Card(CardType.HEART, 12))
//                  .value,
//              2);
//        });
      }); //end PlayCard
      group('PlayCardAi:', () {
        Ki ai = new Ki('ai_dummy', 0); //ai zum testen
      }); //end PlayCardAi //worthless because its private
      group('PutBet', () {
        Ki ai = new Ki('ai_dummy', 0); //ai zum testen
//        test('should do it', () {
//          ai.lastPlayer = false;
//          List<Card> handCards = [Card(CardType.HEART, 13), Card(CardType.HEART, 10), Card(CardType.JESTER, 0)];
//          ai.putBet(3, 1, trump: CardType.HEART, alreadyPlayedCards: [], playedCards: []);
//          expect(ai.bet, 1);
//          //todo improve (not ready yet)
//        });
      }); //end PutBet
    }); // end KI
    group('KuenstlicheIntelligenz:', () {
      //todo maybe test private methods by making them unprivate for tests
      group('PickTrumpCard:', () {
        test('club', () {
          KuenstlicheIntelligenz ai =
              new KuenstlicheIntelligenz('kuenstlicheIntelligenz_dummy', 0);
          List<GameCard> deckList = [
            new GameCard(CardType.CLUB, 4),
            new GameCard(CardType.JESTER, 0),
            new GameCard(CardType.HEART, 5),
            new GameCard(CardType.CLUB, 7),
            new GameCard(CardType.DIAMOND, 4)
          ];
          Deck deck = new Deck();
          deck.deck = deckList;
          while (deck.size() > 0) {
            ai.addCard(deck);
          }
          expect(ai.pickTrumpCard(), CardType.CLUB);
        });
        test('spade', () {
          KuenstlicheIntelligenz ai =
              new KuenstlicheIntelligenz('kuenstlicheIntelligenz_dummy', 0);
          List<GameCard> deckList = [
            new GameCard(CardType.SPADE, 4),
            new GameCard(CardType.JESTER, 0),
            new GameCard(CardType.HEART, 5),
            new GameCard(CardType.SPADE, 7),
            new GameCard(CardType.DIAMOND, 4)
          ];
          Deck deck = new Deck();
          deck.deck = deckList;
          while (deck.size() > 0) {
            ai.addCard(deck);
          }
          expect(ai.pickTrumpCard(), CardType.SPADE);
        });
        test('diamond', () {
          KuenstlicheIntelligenz ai =
              new KuenstlicheIntelligenz('kuenstlicheIntelligenz_dummy', 0);
          List<GameCard> deckList = [
            new GameCard(CardType.DIAMOND, 4),
            new GameCard(CardType.JESTER, 0),
            new GameCard(CardType.DIAMOND, 5),
            new GameCard(CardType.CLUB, 7),
            new GameCard(CardType.DIAMOND, 4)
          ];
          Deck deck = new Deck();
          deck.deck = deckList;
          while (deck.size() > 0) {
            ai.addCard(deck);
          }
          expect(ai.pickTrumpCard(), CardType.DIAMOND);
        });
        test('heart', () {
          KuenstlicheIntelligenz ai =
              new KuenstlicheIntelligenz('kuenstlicheIntelligenz_dummy', 0);
          List<GameCard> deckList = [
            new GameCard(CardType.HEART, 4),
            new GameCard(CardType.JESTER, 0),
            new GameCard(CardType.HEART, 5),
            new GameCard(CardType.CLUB, 7),
            new GameCard(CardType.DIAMOND, 4)
          ];
          Deck deck = new Deck();
          deck.deck = deckList;
          while (deck.size() > 0) {
            ai.addCard(deck);
          }
          expect(ai.pickTrumpCard(), CardType.HEART);
        });

        //todo need to test random bei only wiz or jes
//        test('nonsense', () {
//
//        });
      }); //end PickTrumpCard
      group('findBestCard:', () {
        test('test it', () {
          KuenstlicheIntelligenz ai =
              new KuenstlicheIntelligenz('kuenstlicheIntelligenz_dummy', 0);
        });
      });
      group('PlayCard:', () {
        test('test-funzt_es_überhaupt', () {
          KuenstlicheIntelligenz ai =
              new KuenstlicheIntelligenz('kuenstlicheIntelligenz_dummy', 0);
          //todo improve _getWahrscheinlichkeit zum legen so da es richtig wird
//          List<Card> deckList = [
//            new Card(CardType.HEART, 2),
//            new Card(CardType.JESTER, 0),
//            new Card(CardType.HEART, 10),
//            new Card(CardType.CLUB, 7),
//            new Card(CardType.DIAMOND, 4)
//          ];
//          for (int i = 0; i < deckList.length; i++) {
//            if(CardType.HEART == deckList[i].cardType) deckList[i].allowedToPlay = true;
//          }
//          Deck deck = new Deck();
//          deck.deck = deckList;
//          while (deck.size() > 0) {
//            ai.addCard(deck);
//          }
//          ai.creatingPlayableHandCardsList();
//          List<Card> playedCards = [
//            new Card(CardType.HEART, 6),
//            new Card(CardType.CLUB, 3)
//          ];
//          ai.tricks = 0;
//          ai.bet = 2;
//          expect(ai.playCard(1, trump: CardType.HEART,
//              foe: new Card(CardType.HEART, 6),
//              roundNumber: 5,
//              playerNumber: 3,
//              playedCards: playedCards,
//              highestCard: new Card(CardType.HEART, 6)), new Card(CardType.HEART, 10));
        });
      }); //end PlayCard
      group('PlayCardAI:', () {
        //todo maybe no tests because it is private an only through the methodes of a higher level
      }); //end PlayCardAi //worthless because its private
      group('PutBet:', () {}); //end PutBet
      group('FindBestCard:', () {}); //end FindBestCard
      group('FindWorstCard:', () {}); //end FindWorstCard
      //todo kein plan ob private klassen testbar sind
      ///
      ///
      ///
      group('GetWahrscheinlichkeitBet:', () {}); //end GetWahrscheinlichkeitBet
      group(
          'GetWahrscheinlichkeitPlay:', () {}); //end GetWahrscheinlichkeitPlay
      group('RemoveCardsFromAiDeck:', () {}); //end RemoveCardsFromAiDeck
    }); //end KuenstlicheIntelligenz
    group('Ai:', () {
      group('PickTrumpCard:', () {
        //todo not implemented in class Ai
      }); //end PickTrumpCard
      group('PlayCard:', () {}); //end PlayCard
      group('PlayCardAI:', () {}); //end PlayCardAi
      group('PutBet:', () {}); //end PutBet
      group('FindCard:', () {}); //end FindCard
    }); //end Ai
  }); // end of ALL
}

overridePrint(testFn()) => () {
      var spec = new ZoneSpecification(print: (_, __, ___, String msg) {
        // Add to log instead of printing to stdout
        log.add(msg);
      });
      return Zone.current.fork(specification: spec).run(testFn);
    };
