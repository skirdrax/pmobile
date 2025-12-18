import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF6FA8DC),        // Soft Blue utama
      secondary: Color(0xFFAFCBEF),      // Soft Blue muda
      background: Color(0xFFF4F8FF),     // Background super halus
      surface: Colors.white,             // Card / dialog
      onPrimary: Colors.white,           // Text di AppBar / FAB
      onBackground: Color(0xFF1C1C1C),   // Text utama
      onSurface: Color(0xFF1C1C1C),
    ),
    scaffoldBackgroundColor: const Color(0xFFF4F8FF),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF6FA8DC),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF6FA8DC),
      foregroundColor: Colors.white,
    ),
    cardColor: Colors.white,
  );

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6FA8DC),
      secondary: Color(0xFFAFCBEF),
      background: Color(0xFF0F1115),
      surface: Color(0xFF1A1C20),
      onPrimary: Colors.white,
      onBackground: Colors.white,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFF0F1115),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF6FA8DC),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF6FA8DC),
      foregroundColor: Colors.white,
    ),
    cardColor: const Color(0xFF1A1C20),
  );
}
