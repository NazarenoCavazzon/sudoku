import 'package:flutter/services.dart';

class NoZeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '0') {
      return oldValue;
    }
    return newValue;
  }
}
