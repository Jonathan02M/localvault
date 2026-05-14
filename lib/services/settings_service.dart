import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService extends ChangeNotifier {
  static const String keyDarkMode = 'settings_dark_mode_v2';
  static const String keyLanguage = 'settings_language_v2';
  static const String keyNotifications = 'settings_notifications_v2';

  bool _darkMode = false;
  String _language = 'Português';
  bool _notifications = true;

  bool get darkMode => _darkMode;
  String get language => _language;
  bool get notifications => _notifications;
  ThemeMode get themeMode => _darkMode ? ThemeMode.dark : ThemeMode.light;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _darkMode = prefs.getBool(keyDarkMode) ?? false;
    _language = prefs.getString(keyLanguage) ?? 'Português';
    _notifications = prefs.getBool(keyNotifications) ?? true;
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    _darkMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyDarkMode, value);
    notifyListeners();
  }

  Future<void> setLanguage(String value) async {
    _language = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyLanguage, value);
    notifyListeners();
  }

  Future<void> setNotifications(bool value) async {
    _notifications = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyNotifications, value);
    notifyListeners();
  }
}
