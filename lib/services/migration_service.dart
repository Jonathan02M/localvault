import 'package:shared_preferences/shared_preferences.dart';
import 'settings_service.dart';

class MigrationService {
  static const String dataVersionKey = 'data_version';
  static const int currentVersion = 2;

  static const String oldDarkModeKey = 'darkMode';
  static const String oldLanguageKey = 'language';
  static const String oldNotificationsKey = 'notifications';

  Future<void> migrateIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final savedVersion = prefs.getInt(dataVersionKey) ?? 1;

    if (savedVersion < currentVersion) {
      await _migrateV1ToV2(prefs);
      await prefs.setInt(dataVersionKey, currentVersion);
    }
  }

  Future<void> _migrateV1ToV2(SharedPreferences prefs) async {
    final oldDarkMode = prefs.getBool(oldDarkModeKey);
    final oldLanguage = prefs.getString(oldLanguageKey);
    final oldNotifications = prefs.getBool(oldNotificationsKey);

    if (oldDarkMode != null) {
      await prefs.setBool(SettingsService.keyDarkMode, oldDarkMode);
      await prefs.remove(oldDarkModeKey);
    }
    if (oldLanguage != null) {
      await prefs.setString(SettingsService.keyLanguage, oldLanguage);
      await prefs.remove(oldLanguageKey);
    }
    if (oldNotifications != null) {
      await prefs.setBool(SettingsService.keyNotifications, oldNotifications);
      await prefs.remove(oldNotificationsKey);
    }
  }
}
