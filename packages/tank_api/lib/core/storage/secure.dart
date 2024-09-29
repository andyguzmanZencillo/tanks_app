import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// {@template secure}
/// Secure Storage with flutter_secure_storage
/// {@endtemplate}
class Secure {
  /// {@macro secure}
  Secure._internal();
  static final _instance = Secure._internal();
  static Secure get instance => _instance;

  final _secure = const FlutterSecureStorage();

  /// Save value by [key] in `Flutter Secure Storage`
  Future<void> write(String key, String value) async {
    await _secure.write(key: key, value: value);
  }

  /// Get value by [key] in `Flutter Secure Storage`
  Future<String?> read(String key) {
    return Future.value(_secure.read(key: key));
  }

  /// Clear all values in `Flutter Secure Storage`
  Future<void> clear() async {
    await _secure.deleteAll();
  }

  /// Remove value by [key] from `Flutter Secure Storage`
  Future<bool> hasKey(String key) async {
    return _secure.containsKey(key: key);
  }
}
