import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const prefKey = "theme";

  setTheme(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(prefKey, value);
  }

  Future<String> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(prefKey) ?? '';
  }
}
