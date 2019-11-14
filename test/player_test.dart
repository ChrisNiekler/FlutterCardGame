import 'package:test/test.dart';
import 'package:wizard/cardType.dart';
import 'package:wizard/humanPlayer.dart';

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
