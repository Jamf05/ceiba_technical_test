import 'package:ceiba_technical_test/core/validators/text_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {});

  test('should be able to use the pure constructor and be pure', () async {
    // arrange
    // act
    final input = TextFormInput.pure(start: 0, end: 10);
    // assert
    expect(input.isPure, true);
    expect(input.start, 0);
    expect(input.end, 10);
  });

  test('should be able to use the dirty constructor and be not pure', () async {
    // arrange
    // act
    final input = TextFormInput.dirty('', start: 0, end: 10);
    // assert
    expect(input.isPure, false);
    expect(input.start, 0);
    expect(input.end, 10);
  });

  test('should can change a value from a pure input', () async {
    // arrange
    // act
    var input = TextFormInput.pure(start: 0, end: 10);
    input = input.copyWith('value');
    // assert
    expect(input.value, 'value');
    expect(input.start, 0);
    expect(input.end, 10);
  });

  group('Method validator', () {
    test('should be invalid if it is not pure', () async {
      // arrange
      // act
      var input = TextFormInput.pure(start: 0, end: 10);
      // assert
      expect(input.isValid, false);
    });

    test('should be invalid if it does not meet both limits', () async {
      // arrange
      // act
      var input = TextFormInput.pure(start: 0, end: 3);
      input = input.copyWith('value');
      // assert
      expect(input.isValid, false);
    });

    test('should be invalid if it does not meet start limit', () async {
      // arrange
      // act
      var input = TextFormInput.pure(start: 10);
      input = input.copyWith('valueeeeeeeeeeeeeee');
      // assert
      expect(input.isValid, true);
    });

    test('should be invalid if it does not meet end limit', () async {
      // arrange
      // act
      var input = TextFormInput.pure(end: 10);
      input = input.copyWith('value');
      // assert
      expect(input.isValid, true);
    });
  });
}
