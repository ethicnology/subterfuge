import 'package:flutter/material.dart';

final base = ColorScheme.dark();

final customScheme = base.copyWith(
  primary: Colors.tealAccent,
  secondary: Colors.tealAccent,
  tertiary: Colors.tealAccent,
  surface: Colors.black,
);

ThemeData get appTheme =>
    ThemeData(colorScheme: customScheme, useMaterial3: true);
