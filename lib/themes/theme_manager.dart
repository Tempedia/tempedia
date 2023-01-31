import 'package:flutter/material.dart';
import 'package:tempedia/themes/theme_preference.dart';

final List<ThemeData> _themeList = [
  ThemeData(primarySwatch: Colors.blue),
  ThemeData(primarySwatch: Colors.cyan),
  ThemeData(primarySwatch: Colors.teal),
  ThemeData(primarySwatch: Colors.green),
  ThemeData(primarySwatch: Colors.lime),
  ThemeData(primarySwatch: Colors.yellow),
  ThemeData(primarySwatch: Colors.orange),
  ThemeData(primarySwatch: Colors.pink),
  ThemeData(primarySwatch: Colors.red),
  ThemeData(primarySwatch: Colors.purple),
  ThemeData(primarySwatch: Colors.indigo),
  ThemeData.dark(useMaterial3: true),
];

class ThemeManager extends ChangeNotifier {
  static final ThemePreferences _preferences = ThemePreferences();
  static ThemeData? initialTheme;
  ThemeManager() {
    if (initialTheme != null) {
      currentTheme = initialTheme!;
    } else {
      currentTheme = themeList[0];
      readPreferences().then((value) {
        currentTheme = value;
        notifyListeners();
      });
    }
  }

  static init() async {
    initialTheme = await readPreferences();
  }

  static List<ThemeData> get themeList => _themeList;

  setTheme(ThemeData theme) {
    currentTheme = theme;
    _preferences.setTheme(currentTheme.primaryColor.toString());
    notifyListeners();
  }

  ThemeData get theme => currentTheme;

  late ThemeData currentTheme;
  static Future<ThemeData> readPreferences() async {
    String name = await _preferences.getTheme();
    for (var theme in _themeList) {
      if (name == theme.primaryColor.toString()) {
        return theme;
      }
    }
    return _themeList[0];
  }
}
