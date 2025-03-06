import 'package:flutter/material.dart';

extension HexadecimalColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color from(String color) {
    final buffer = StringBuffer();
    if (color.length == 6 || color.length == 7) buffer.write('ff');
    buffer.write(color.replaceFirst('#', ''));
    final value = int.tryParse(buffer.toString(), radix: 16);
    if (value != null) {
      return Color(value);
    } else {
      return Colors.transparent;
    }
  }
}