import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const String tokenKey = 'secure_auth_token_v2';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return _storage.read(key: tokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: tokenKey);
  }
}
