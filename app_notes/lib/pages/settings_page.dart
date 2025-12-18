import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../services/auth_api.dart';
import 'login_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ===============================================
            // SETTINGS CARD
            // ===============================================
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Dark Mode Toggle
                  SwitchListTile(
                    title: const Text(
                      "Dark Mode",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    value: settings.isDark,
                    onChanged: (_) => settings.toggleTheme(),
                  ),

                  const Divider(height: 20),

                  // Last opened note
                  if (settings.lastOpenedNote != null)
                    ListTile(
                      title: const Text("Last Opened Note ID"),
                      subtitle: Text(
                        "${settings.lastOpenedNote}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      leading: const Icon(Icons.history),
                    ),
                ],
              ),
            ),

            const Spacer(),

            // ===============================================
            // LOGOUT BUTTON
            // ===============================================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                onPressed: () async {
                  final auth = AuthApi();

                  // Logout ke server
                  await auth.logout();

                  // Pindah balik ke login
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
