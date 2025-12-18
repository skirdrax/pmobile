import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? _prefs;

  // Dipanggil sekali di main()
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ------------------------
  // THEME MODE
  // ------------------------
  static Future setTheme(bool isDark) async {
    await _prefs?.setBool("isDark", isDark);
  }

  static bool getTheme() {
    return _prefs?.getBool("isDark") ?? false;
  }

  // ------------------------
  // LAST OPENED NOTE ID
  // ------------------------
  static Future setLastNoteId(int id) async {
    await _prefs?.setInt("lastNote", id);
  }

  static int? getLastNoteId() {
    return _prefs?.getInt("lastNote");
  }

  // ========================
  //        AUTH TOKEN
  // ========================
  static Future saveToken(String token) async {
    await _prefs?.setString("token", token);
  }

  static String? getToken() {
    return _prefs?.getString("token");
  }

  static Future clearToken() async {
    await _prefs?.remove("token");
  }
}
