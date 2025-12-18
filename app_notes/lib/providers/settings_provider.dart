import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/shared_pref.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isDark = false;
  int? _lastOpenedNote;

  bool get isDark => _isDark;
  int? get lastOpenedNote => _lastOpenedNote;

  ThemeData get currentTheme =>
      _isDark ? AppTheme.darkTheme : AppTheme.lightTheme;

  Future<void> loadPrefs() async {
    _isDark = SharedPref.getTheme();
    _lastOpenedNote = SharedPref.getLastNoteId();
    notifyListeners();
  }

  void toggleTheme() {
    _isDark = !_isDark;
    SharedPref.setTheme(_isDark);
    notifyListeners();
  }

  void saveLastOpened(int id) {
    _lastOpenedNote = id;
    SharedPref.setLastNoteId(id);
  }
}
