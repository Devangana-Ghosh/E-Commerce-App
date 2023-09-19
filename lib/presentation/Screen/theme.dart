import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData lightTheme = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    // Add other light mode theme properties here
  );

  ThemeData darkTheme = ThemeData.dark().copyWith(
    backgroundColor: Colors.black12,
    // Add other dark mode theme properties here
  );

  ThemeData currentTheme = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    // Set the initial background color for light mode
  );

  void toggleTheme() {
    currentTheme =
    currentTheme == lightTheme ? darkTheme : lightTheme; // Toggle between themes
    notifyListeners();
  }
}
