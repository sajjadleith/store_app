import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServcie {
  SharedPrefServcie() {
    init();
  }

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setData(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static String? getData(String key) {
    final dat = _prefs.getString(key);
    return dat;
  }

  static Future<void> removeData(String key) async {
    await _prefs.remove(key);
  }
}
