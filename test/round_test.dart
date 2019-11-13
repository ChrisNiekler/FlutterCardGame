import 'package:test/test.dart';

void main() {
  group('ALL:', () {
    group('group1:', () {
      test('Something', () {
        fail('not yet implemented');
      });
      test('Something esle', () {
        fail('not yet implemented');
      });
    }); // end group1

    group('group1:', () {
      test('Something', () {
        fail('not yet implemented');
      });
      test('Something esle', () {
        fail('not yet implemented');
      });
    }); // end group2
  }); // end of ALL
}
