import 'dart:async';
import 'package:test/test.dart';
import 'package:wizard/card.dart';
import 'package:wizard/cardType.dart';
import 'package:wizard/humanPlayer.dart';
import 'package:wizard/ki.dart';

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
      Ki ai = new Ki('ai_dummy', 0); //ai zum testen
      /*group('PickTrumpCard:', (){
        test('test it', () {
          fail('not yet implemented');
        });
      });//end PickTrumpCard*/
      /*group('PlayCard:', (){
        test('Something esle', () {
          fail('not yet implemented');
        });
      });//end PlayCard*/
      group('PlayCardAi:',
          () {}); //end PlayCardAi //worthless because its private
      group('PutBet', () {
        test('should do it', () {
          ai.lastPlayer = false;
          List<Card> handCards = [
            Card(CardType.HEART, 13),
            Card(CardType.HEART, 10),
            Card(CardType.JESTER, 0)
          ];
          ai.putBet(3, 1,
              trump: CardType.HEART, alreadyPlayedCards: [], playedCards: []);
          expect(ai.bet, 1);
          //todo improve (not ready yet)
        });
      }); //end PutBet
    }); // end KI
    group('KuenstlicheIntelligenz:', () {
      group('PickTrumpCard:', () {
        test('test it', () {
          fail('not yet implemented');
        });
      }); //end PickTrumpCard
      group('PlayCard:', () {}); //end PlayCard
      group('PlayCardAI:',
          () {}); //end PlayCardAi //worthless because its private
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
