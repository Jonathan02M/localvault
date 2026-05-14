import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../models/user_profile.dart';
import '../services/storage_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _scoreController = TextEditingController(text: '0');
  final _tokenController = TextEditingController();
  final _storageService = StorageService();

  String? _shownToken;
  Box<UserProfile> get _profileBox => Hive.box<UserProfile>('user_profile_box');

  @override
  void initState() {
    super.initState();
    final profile = _profileBox.get('profile');
    if (profile != null) {
      _nameController.text = profile.name;
      _emailController.text = profile.email;
      _scoreController.text = profile.score.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _scoreController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final profile = UserProfile(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      registrationDate: DateTime.now(),
      score: int.tryParse(_scoreController.text.trim()) ?? 0,
    );

    await _profileBox.put('profile', profile);
    if (!mounted) return;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Perfil salvo com Hive!')));
  }

  Future<void> _clearProfile() async {
    await _profileBox.delete('profile');
    _nameController.clear();
    _emailController.clear();
    _scoreController.text = '0';
    if (!mounted) return;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dados apagados — direito ao esquecimento LGPD.')));
  }

  Future<void> _saveToken() async {
    await _storageService.saveToken(_tokenController.text.trim());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Token salvo com segurança!')));
  }

  Future<void> _loadToken() async {
    final token = await _storageService.getToken();
    if (!mounted) return;
    setState(() => _shownToken = token ?? 'Nenhum token encontrado.');
  }

  Future<void> _deleteToken() async {
    await _storageService.deleteToken();
    if (!mounted) return;
    _tokenController.clear();
    setState(() => _shownToken = 'Token deletado.');
  }

  @override
  Widget build(BuildContext context) {
    final profile = _profileBox.get('profile');
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil e Segurança')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Perfil do Usuário — Hive', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nome', border: OutlineInputBorder())),
                  const SizedBox(height: 12),
                  TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'E-mail', border: OutlineInputBorder())),
                  const SizedBox(height: 12),
                  TextField(controller: _scoreController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Pontuação', border: OutlineInputBorder())),
                  const SizedBox(height: 16),
                  FilledButton.icon(onPressed: _saveProfile, icon: const Icon(Icons.save), label: const Text('Salvar perfil')),
                  TextButton.icon(onPressed: _clearProfile, icon: const Icon(Icons.delete_forever), label: const Text('Limpar dados do perfil — LGPD')),
                  if (profile != null) ...[
                    const Divider(height: 30),
                    Text('Nome: ${profile.name}'),
                    Text('E-mail: ${profile.email}'),
                    Text('Cadastro: ${dateFormat.format(profile.registrationDate)}'),
                    Text('Pontuação: ${profile.score}'),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Armazenamento Seguro', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  TextField(controller: _tokenController, decoration: const InputDecoration(labelText: 'Token fictício', hintText: 'abc123-token-localvault', border: OutlineInputBorder())),
                  const SizedBox(height: 12),
                  FilledButton.icon(onPressed: _saveToken, icon: const Icon(Icons.lock), label: const Text('Salvar token')),
                  OutlinedButton.icon(onPressed: _loadToken, icon: const Icon(Icons.visibility), label: const Text('Recuperar token')),
                  TextButton.icon(onPressed: _deleteToken, icon: const Icon(Icons.delete), label: const Text('Deletar token')),
                  if (_shownToken != null) ...[
                    const Divider(height: 30),
                    SelectableText('Token: $_shownToken'),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
