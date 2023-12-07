import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static late SharedPreferences _preferences;

  Future<void> getInstance() async {
    _preferences = await SharedPreferences.getInstance();
  }

  factory SharedPreferencesUtil() => _instance;

  static final SharedPreferencesUtil _instance = SharedPreferencesUtil._internal();

  SharedPreferencesUtil._internal();

  void setBool(String key, bool value) {
    _preferences.setBool(key, value);
  }

  getBool(String key) {
    return _preferences.getBool(key);
  }

  void setString(String key, String? value) {
    _preferences.setString(key, value ?? "");
  }

  String getString(String key) {
    return _preferences.getString(key) ?? "";
  }
}
