import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/notes_provider.dart';
import 'providers/settings_provider.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';     // ← TAMBAH INI
import 'utils/shared_pref.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPref.init();

  // Ambil token dulu
  final token = SharedPref.getToken();

  // Load setting
  final settingsProvider = SettingsProvider();
  await settingsProvider.loadPrefs();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotesProvider()),
        ChangeNotifierProvider(create: (_) => settingsProvider),
      ],
      child: NotesApp(startPage: token == null ? const LoginPage() : const HomePage()),
    ),
  );
}

class NotesApp extends StatelessWidget {
  final Widget startPage;

  const NotesApp({required this.startPage, super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settings.isDark ? ThemeMode.dark : ThemeMode.light,

      home: startPage,   // ← GANTI INI
    );
  }
}
