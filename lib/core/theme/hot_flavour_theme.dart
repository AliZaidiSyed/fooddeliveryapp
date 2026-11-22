import 'package:flutter/material.dart';

/// Hot Flavour's reusable brand colors. Keep functional status colors distinct.
abstract final class HotFlavourColors {
  static const Color primary = Color(0xFFD71920); // flame red
  static const Color deepRed = Color(0xFFA90D19);
  static const Color orange = Color(0xFFFF6B24);
  static const Color cream = Color(0xFFFFF5ED);
  static const Color softRed = Color(0xFFFFE8E3);
  static const Color surface = Color(0xFFFFFAF6);
  static const Color ink = Color(0xFF271A18);
  static const Color muted = Color(0xFF735D58);
  static const Color success = Color(0xFF20804A);
}

abstract final class HotFlavourTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: HotFlavourColors.primary,
      brightness: Brightness.light,
      primary: HotFlavourColors.primary,
      secondary: HotFlavourColors.orange,
      surface: HotFlavourColors.surface,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      primaryColor: HotFlavourColors.primary,
      scaffoldBackgroundColor: HotFlavourColors.surface,
      canvasColor: HotFlavourColors.surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: HotFlavourColors.surface,
        foregroundColor: HotFlavourColors.ink,
        elevation: 0,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: HotFlavourColors.cream,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: HotFlavourColors.primary, width: 1.6)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: HotFlavourColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: HotFlavourColors.primary,
        foregroundColor: Colors.white,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: HotFlavourColors.primary),
      textSelectionTheme: const TextSelectionThemeData(cursorColor: HotFlavourColors.primary, selectionHandleColor: HotFlavourColors.primary),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: HotFlavourColors.ink,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
