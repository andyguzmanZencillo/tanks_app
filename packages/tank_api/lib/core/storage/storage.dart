import 'dart:async';

import 'package:get_storage/get_storage.dart';

/// {@template storage}
/// Storage Storage with get_storage
/// {@endtemplate}
class Storage {
  /// {@macro storage}
  Storage._internal();
  static final _instance = Storage._internal();
  static Storage get instance => _instance;

  final _controller = StreamController<String>.broadcast();
  Stream<String> get stream => _controller.stream;

  final _storage = GetStorage();

  /// Save value by [key] in `GetStorage`
  Future<void> write(String key, dynamic value) async {
    await _storage.write(key, value);
    // _controller.add(key);
  }

  /*Future<void> write2(String key, dynamic value) async {
    await _storage.write(key, value);
  }*/

  /// Get value by [key] in `GetStorage`
  T? read<T>(String key) {
    return _storage.read<T>(key);
  }

  /// Clear all values in `GetStorage`
  Future<void> clear() async {
    await _storage.erase();
  }

  /// Remove value by [key] from `GetStorage`
  Future<bool> hasKey(String key) async {
    return _storage.hasData(key);
  }

  void dispose() {
    _controller.close();
  }
}
