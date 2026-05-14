import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/settings_service.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();

    return Scaffold(
      appBar: AppBar(title: const Text('LocalVault'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Cofre Local de Dados', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Idioma: ${settings.language}'),
                    Text('Notificações: ${settings.notifications ? 'Ativadas' : 'Desativadas'}'),
                    Text('Tema: ${settings.darkMode ? 'Escuro' : 'Claro'}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              icon: const Icon(Icons.settings),
              label: const Text('Configurações'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
            ),
            const SizedBox(height: 12),
            FilledButton.tonalIcon(
              icon: const Icon(Icons.person),
              label: const Text('Perfil e Segurança'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
            ),
            const Spacer(),
            const Text(
              'LGPD: o app permite salvar, visualizar e excluir dados locais, incluindo o direito ao esquecimento.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
