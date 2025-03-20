import 'dart:ui';

import 'package:ceiba_technical_test/core/extensions/color.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {});

  group('HexadecimalColor', () {
    test('Nostrud Lorem adipisicing anim labore cillum nulla anim ex non duis mollit consequat.', () async {
      // arrange
      const tTextColor = '#ff0000';
      // act
      final tColor = HexadecimalColor.from(tTextColor);
      // assert
      expect(tColor, isA<Color>());
    });
  });
}
