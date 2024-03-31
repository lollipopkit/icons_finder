import 'package:flutter/material.dart';

extension IconDataX on IconData {
  String get description {
    return '$fontFamily ${codePoint.toRadixString(16)}';
  }
}

extension StringX on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';
}
