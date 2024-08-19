import 'dart:developer';

import 'package:socialverse/export.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;
  ThemeProvider(this._themeData) {
    _loadThemeMode();
  }
  getTheme() => _themeData;

  ThemeMode _selectedThemeMode = themeMode ?? ThemeMode.system;
  ThemeMode get selectedThemeMode => _selectedThemeMode;

  Future<void> _loadThemeMode() async {
    var prefs = await SharedPreferences.getInstance();
    var themeModeString = prefs.getString('themeMode');
    if (themeModeString != null) {
      _selectedThemeMode = themeModeFromString(themeModeString);
    }
  }

  ThemeMode themeModeFromString(String themeModeString) {
    switch (themeModeString) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      case 'ThemeMode.system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  void onThemeChanged(String themeMode) async {
    var theme = themeModeFromString(themeMode);
    switch (theme) {
      case ThemeMode.light:
        setTheme(Constants.lightTheme);
        break;
      case ThemeMode.dark:
        setTheme(Constants.darkTheme);
        break;
      case ThemeMode.system:
        setTheme(Constants.lightTheme);
        break;
    }
    notifyListeners();
  }

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  setSelectedThemeMode(ThemeMode _themeMode) async {
    _selectedThemeMode = _themeMode;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', _themeMode.toString());
    log(_themeMode.toString());
    onThemeChanged(_themeMode.toString());
    notifyListeners();
  }
}
