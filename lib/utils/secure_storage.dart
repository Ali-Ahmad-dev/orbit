import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  final String _keyUsername = 'Email';
  final String _keyPassword = 'Password';
  final String _keyFingerprint = 'Fingerprint';

  Future<void> saveUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, email);
    await prefs.setString(_keyPassword, password);
  }

  Future<void> saveFingerprint(String toggle) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyFingerprint, toggle);
  }

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPassword);
  }

  Future<String?> getFingerprint() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyFingerprint);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUsername);
    await prefs.remove(_keyPassword);
  }

  Future<void> clearFingerprint() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyFingerprint);
  }
}
