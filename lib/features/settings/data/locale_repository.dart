import 'package:shared_preferences/shared_preferences.dart';

class LocaleRepository {
  static const _keyLocale = 'locale';

  Future<String?> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLocale);
  }

  Future<void> saveLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLocale, languageCode);
  }
}
