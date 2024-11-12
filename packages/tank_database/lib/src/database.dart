import 'dart:developer';
import 'dart:io';

import 'package:failures/failures.dart';
import 'package:isar/isar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tank_database/src/features/features.dart';

/// {@template database}
/// Database with isar
/// {@endtemplate}

enum UriDB {
  pathMain('', ''),
  pathDB('/storage/emulated/0/TANQUES/DB', 'default.isar'),
  pathBackup('/storage/emulated/0/TANQUES/BACKUP', 'default.isar'),
  pathDowload('/storage/emulated/0/Download/', 'default.isar');

  const UriDB(this.uri, this.file);
  final String uri;
  final String file;
}

class Database {
  /// {@macro database}
  Database._internal();
  static final _instance = Database._internal();
  static Database get instance => _instance;

  Isar? _database;

  Future<void> initAvanced() async {
    //Set permissions to access files local device
    final isPermissions = await permissions();
    if (!isPermissions) return;

    //Set verification a initial database directory local device
    final packageInfo = await PackageInfo.fromPlatform();
    final pathDirectory = '${UriDB.pathDB.uri}/${packageInfo.appName.trim()}';
    final pathFile = '$pathDirectory/${UriDB.pathDB.file}';
    final isExist = await _existDirectory(pathDirectory);
    if (isExist) {
      final isExistFile = await _existFile(pathFile);
      if (isExistFile) {
        await _loadDataBase(pathDirectory);
        return;
      }
    }
    final dir = await getApplicationDocumentsDirectory();
    await _loadDataBase(dir.path);

    await _createDirectoryIfNotExists(pathDirectory);

    await _database!.copyToFile(pathFile);
    await _database!.close();
    await _loadDataBase(pathDirectory);
  }

  Future<void> _loadDataBase(String path) async {
    _database = await Isar.open(IsarSchemes.list, directory: path);
  }

  Future<bool> permissions() async {
    final permissionStatus = await Permission.manageExternalStorage.status;
    if (permissionStatus.isDenied) {
      await Permission.manageExternalStorage.request();

      if (permissionStatus.isDenied) {
        final res = await openAppSettings();
        return res;
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      final res = await openAppSettings();
      return res;
    } else {
      return true;
    }
    return false;
  }

  Future<Directory> _createDirectoryIfNotExists(String customPath) async {
    if (!(await _existDirectory(customPath))) {
      final targetDir = Directory(customPath);
      await targetDir.create(recursive: true);
    }
    return Directory(customPath);
  }

  Future<bool> _existDirectory(String path) async {
    final targetDir = Directory(path);

    // ignore: avoid_slow_async_io
    final exist = await targetDir.exists();

    return exist;
  }

  Future<bool> _existFile(String path) async {
    // ignore: avoid_slow_async_io
    final exist = await File(path).exists();
    return exist;
  }

  /// Save Collection to Isar
  Future<void> save<T>(T object) async {
    try {
      await _database!.writeTxn(() async {
        final collection = _database!.collection<T>();
        await collection.put(object);
      });
    } catch (e) {
      log('EXCEPTION DATABASE $T ===> $e');
      throw DatabaseErrorException();
    }
  }

  /// Save a List of Collections to Isar
  Future<void> saveMany<T>(List<T> objects) async {
    try {
      await _database!.writeTxn(() async {
        final collection = _database!.collection<T>();
        await collection.putAll(objects);
      });
    } catch (e) {
      log('EXCEPTION DATABASE $T ===> $e');
      throw DatabaseErrorException();
    }
  }

  /// Get a Collection from Isar
  Future<T> getById<T>(int id) async {
    try {
      // await _database.writeTxn(() async {
      final collection = _database!.collection<T>();
      final item = await collection.get(id);
      return item!;
      // });
    } catch (e) {
      log('EXCEPTION DATABASE $T ===> $e');
      throw DatabaseErrorException();
    }
  }

  /// Clear and Save Collection to Isar
  Future<void> clearAndSave<T>(T object) async {
    try {
      await _database!.writeTxn(() async {
        final collection = _database!.collection<T>();
        await collection.clear();
        await collection.put(object);
      });
    } catch (e) {
      log('EXCEPTION DATABASE $T ===> $e');
      throw DatabaseErrorException();
    }
  }

  /// Clear and Save a List of Collections to Isar
  Future<void> clearAndSaveMany<T>(List<T> objects) async {
    try {
      await _database!.writeTxn(() async {
        final collection = _database!.collection<T>();
        await collection.clear();
        await collection.putAll(objects);
      });
    } catch (e) {
      log('EXCEPTION DATABASE $T ===> $e');
      throw DatabaseErrorException();
    }
  }

  Future<void> clear<T>(int id) async {
    try {
      await _database!.writeTxn(() async {
        final collection = _database!.collection<T>();
        await collection.delete(id);
      });
    } catch (e) {
      log('EXCEPTION DATABASE $T ===> $e');
      throw DatabaseErrorException();
    }
  }

  /// Get a Collection from Isar
  Future<IsarCollection<T>> get<T>() async {
    try {
      final collection = _database!.collection<T>();
      return collection;
    } catch (e) {
      log('EXCEPTION DATABASE $T ===> $e');
      throw DatabaseErrorException();
    }
  }

  /// Get a Collection from Isar
  Future<List<T>> getAll<T>() async {
    try {
      final collection = _database!.collection<T>();
      return collection.where().findAll();
    } catch (e) {
      log('EXCEPTION DATABASE $T ===> $e');
      throw DatabaseErrorException();
    }
  }

  Future<List<T>> getAllByFilter<T>() async {
    try {
      final collection = _database!.collection<T>();
      return collection.where().findAll();
    } catch (e) {
      log('EXCEPTION DATABASE $T ===> $e');
      throw DatabaseErrorException();
    }
  }
}
