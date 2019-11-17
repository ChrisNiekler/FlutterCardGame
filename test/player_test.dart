import 'dart:async';
import 'package:test/test.dart';
import 'package:wizard/cardType.dart';
import 'package:wizard/humanPlayer.dart';

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
      test('Something', () {
        fail('not yet implemented');
      });
      test('Something esle', () {
        fail('not yet implemented');
      });
    }); // end group2
  }); // end of ALL
}

overridePrint(testFn()) => () {
      var spec = new ZoneSpecification(print: (_, __, ___, String msg) {
        // Add to log instead of printing to stdout
        log.add(msg);
      });
      return Zone.current.fork(specification: spec).run(testFn);
    };
