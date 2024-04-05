import 'package:flutter/services.dart';

/// Only allow positive decimal inputs.
class UnsignedDoubleTextInputFormatter implements TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow having no text.
    if (newValue.text.isEmpty) return newValue;

    // Only allow doubles.
    final parsed = double.tryParse(newValue.text);
    if (parsed != null && parsed >= 0) return newValue;

    // Return old value otherwise.
    return oldValue;
  }
}
