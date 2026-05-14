import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/settings_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();

    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Modo escuro'),
            subtitle: const Text('Salvo com SharedPreferences'),
            value: settings.darkMode,
            onChanged: (value) => settings.setDarkMode(value),
          ),
          const Divider(),
          ListTile(
            title: const Text('Idioma'),
            subtitle: const Text('Persistido entre sessões'),
            trailing: DropdownButton<String>(
              value: settings.language,
              items: const [
                DropdownMenuItem(value: 'Português', child: Text('Português')),
                DropdownMenuItem(value: 'English', child: Text('English')),
              ],
              onChanged: (value) {
                if (value != null) settings.setLanguage(value);
              },
            ),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Notificações'),
            subtitle: const Text('Salvo com SharedPreferences'),
            value: settings.notifications,
            onChanged: (value) => settings.setNotifications(value),
          ),
        ],
      ),
    );
  }
}
