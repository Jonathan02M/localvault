import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'adapters/user_profile_adapter.dart';
import 'models/user_profile.dart';
import 'screens/home_screen.dart';
import 'services/migration_service.dart';
import 'services/settings_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(UserProfileAdapter());
  }
  await Hive.openBox<UserProfile>('user_profile_box');

  await MigrationService().migrateIfNeeded();

  final settingsService = SettingsService();
  await settingsService.loadSettings();

  runApp(
    ChangeNotifierProvider<SettingsService>.value(
      value: settingsService,
      child: const LocalVaultApp(),
    ),
  );
}

class LocalVaultApp extends StatelessWidget {
  const LocalVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LocalVault',
      themeMode: settings.themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: const HomeScreen(),
    );
  }
}
