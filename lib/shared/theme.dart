import 'package:flutter/material.dart';

final base = ColorScheme.dark();

// `tertiary` is intentionally NOT the brand teal: it's repurposed as the
// app's dedicated "caution" color (distinct from `error`'s "failure" red),
// e.g. for the SLIP-39 passphrase-verification notice on ShowSecretPage.
// Material 3 has no built-in "warning" role, so tertiary is the closest fit.
final customScheme = base.copyWith(
  primary: Colors.tealAccent,
  secondary: Colors.tealAccent,
  tertiary: Colors.amber,
  onTertiary: Colors.black,
  tertiaryContainer: Colors.amber.withValues(alpha: 0.16),
  onTertiaryContainer: Colors.amber.shade100,
  surface: Colors.black,
);

ThemeData get appTheme => ThemeData(
  colorScheme: customScheme,
  useMaterial3: true,
  snackBarTheme: SnackBarThemeData(
    backgroundColor: customScheme.surfaceContainerHighest,
    contentTextStyle: TextStyle(color: customScheme.onSurface),
    actionTextColor: customScheme.primary,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
);
