import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData lightTheme = ThemeData.light().copyWith(
    backgroundColor: Colors.white,

  );

  ThemeData darkTheme = ThemeData.dark().copyWith(
    backgroundColor: Colors.black12,

  );

  ThemeData currentTheme = ThemeData.light().copyWith(
    backgroundColor: Colors.white,

  );

  void toggleTheme() {
    currentTheme =
    currentTheme == lightTheme ? darkTheme : lightTheme;
    notifyListeners();
  }
}