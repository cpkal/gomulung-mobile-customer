import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    // Define the color scheme with a custom palette
    colorScheme: ColorScheme(
      primary: Color(0xFF285238), // Green (Primary color)
      secondary: Color(0xFF138A36), // Blue (Secondary color)
      surface: Color(0xFFFFFFFF), // White (Surface color for cards)
      error: Color(0xFFF44336), // Red (For error messages)
      onPrimary: Colors.white, // Text on primary color
      onSecondary: Colors.white, // Text on secondary color
      onBackground: Colors.black, // Text on background
      onSurface: Colors.black, // Text on surface
      onError: Colors.white, // Text on error
      brightness: Brightness.light, // Light theme
    ),

    // Define text theme
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: Colors.black, fontSize: 24),
      headlineMedium: TextStyle(color: Colors.black, fontSize: 20),
      headlineSmall: TextStyle(color: Colors.black, fontSize: 18),
      bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 14),
      bodySmall: TextStyle(color: Colors.grey.shade500, fontSize: 12),
    ),

    // Button theme (optional)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF285238), // Button background color
        foregroundColor: Colors.white, // Button text color
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      //border radius
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade700),
        borderRadius: BorderRadius.circular(100),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFF44336)),
        borderRadius: BorderRadius.circular(100),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF285238)),
        borderRadius: BorderRadius.circular(100),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFF44336)),
        borderRadius: BorderRadius.circular(100),
      ),
      //smaller padding
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF285238),
    ),
  );
}
