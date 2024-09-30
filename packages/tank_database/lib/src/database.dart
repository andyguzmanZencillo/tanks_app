import 'dart:developer';
import 'dart:io';

import 'package:failures/failures.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tank_database/src/features/features.dart';

/// {@template database}
/// Database with isar
/// {@endtemplate}

enum UriDB {
  pathMain('', ''),
  pathDB('/storage/emulated/0/POSMOBILE/DB', 'default.isar'),
  pathBackup('/storage/emulated/0/POSMOBILE/BACKUP', 'default.isar'),
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

  /// Database Initializer
  Future<void> initIsar() async {
    final permissionStatus = await Permission.manageExternalStorage.status;
    if (permissionStatus.isDenied) {
      await Permission.manageExternalStorage.request();

      if (permissionStatus.isDenied) {
        await openAppSettings();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      await openAppSettings();
    } else {}
    await getApplicationDocumentsDirectory();
    const path = '/storage/emulated/0/Download/alpes';
    final dir = Directory(path);
    //await createDirectoryIfNotExists(path);
    //final dir = await getApplicationDocumentsDirectory();
    log('ISAR-LOG: Directorio original $dir');
    _database = await Isar.open(
      IsarSchemes.list,
      name: 'backup_db_ALPES_POS1',
      directory: dir.path,
    );
  }

  Future<void> initIsarLeave() async {
    final permissionStatus = await Permission.manageExternalStorage.status;
    if (permissionStatus.isDenied) {
      await Permission.manageExternalStorage.request();

      if (permissionStatus.isDenied) {
        await openAppSettings();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      await openAppSettings();
    } else {}
    await getApplicationDocumentsDirectory();
    const path = '/storage/emulated/0/Download/pos';
    final dir = Directory(path);
    //await createDirectoryIfNotExists(path);
    //final dir = await getApplicationDocumentsDirectory();
    log('ISAR-LOG: Directorio original $dir');
    _database = await Isar.open(
      IsarSchemes.list,
      name: 'backupPM_20240711_102833',
      directory: dir.path,
    );
  }

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    log('ISAR-LOG: $dir');
    _database = await Isar.open(IsarSchemes.list, directory: dir.path);
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

  Future<void> createBackUp() async {
    final permissionStatus = await Permission.manageExternalStorage.status;
    if (permissionStatus.isDenied) {
      await Permission.manageExternalStorage.request();

      if (permissionStatus.isDenied) {
        await openAppSettings();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      final isar = _database;
      const path = '/storage/emulated/0/POSMOBILE/backup';

      await _createDirectoryIfNotExists('/storage/emulated/0/POSMOBILE/backup');

      final backUpDir = Directory(path);
      final name = getName();

      final backUpFile = File('${backUpDir.path}/$name.isar');
      // ignore: avoid_slow_async_io
      final exist = await backUpFile.exists();
      if (exist) {
        await backUpFile.delete();
      }
      await isar!.copyToFile('${backUpDir.path}/$name.isar');
    }
  }

  Future<String?> createBackUpAdvanced(
    String idCompany,
    String idSaleCenter,
    String idSaleSpot,
  ) async {
    final permissionStatus = await Permission.manageExternalStorage.status;

    if (permissionStatus.isDenied) {
      await Permission.manageExternalStorage.request();

      if (permissionStatus.isDenied) {
        await openAppSettings();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      final isar = _database;
      const path = '/storage/emulated/0/POSMOBILE/backup';

      await _createDirectoryIfNotExists('/storage/emulated/0/POSMOBILE/backup');

      final backUpDir = Directory(path);
      final name = getName();

      final backUpFile = File(
        '${backUpDir.path}/$idCompany$idSaleCenter$idSaleSpot$name.isar',
      );
      // ignore: avoid_slow_async_io
      final exist = await backUpFile.exists();
      if (exist) {
        await backUpFile.delete();
      }
      await isar!.copyToFile(backUpFile.path);
      return backUpFile.path;
    }
    return null;
  }

  String getName() {
    final now = DateTime.now();
    final formattedDateTime = DateFormat('yyyyMMdd_HHmmss').format(now);

    final name = 'PM$formattedDateTime';
    return name;
  }

  Future<FilePickerResult> openFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.isNotEmpty) {
        final filePath = result.files.single.path;

        if (filePath != null && filePath.isNotEmpty) {
          final file = File(filePath);

          if (await file.exists()) {
            return result;
          } else {
            log('El archivo no existe en la ruta proporcionada: $filePath');
            throw const FileSystemException();
          }
        } else {
          log('Ruta del archivo no válida.');
          throw const FileSystemException();
        }
      } else {
        log('El usuario canceló la selección del archivo o no se seleccionó ningún archivo.');
        throw const FileSystemException();
      }
    } catch (e) {
      log('Error al seleccionar el archivo: $e');
      throw const FileSystemException();
    }
  }

  Future<void> initIsarToPath(FilePickerResult file) async {
    final permissionStatus = await Permission.manageExternalStorage.status;
    if (permissionStatus.isDenied) {
      await Permission.manageExternalStorage.request();

      if (permissionStatus.isDenied) {
        await openAppSettings();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      await openAppSettings();
    } else {}
    await getApplicationDocumentsDirectory();
    //const path = '/storage/emulated/0/Download/alpes';
    final dir = Directory(file.paths.first!);
    //await createDirectoryIfNotExists(path);
    //final dir = await getApplicationDocumentsDirectory();
    final fullPath = file.files.single.path;
    final directoryPath = p.dirname(fullPath!);
    final fileNameWithoutExtension = p.basenameWithoutExtension(fullPath);
    log('$directoryPath ${file.names.first!}');
    log('ISAR-LOG: Directorio original $dir');
    if (_database != null) {
      if (_database!.isOpen) await _database!.close();
    }
    _database = await Isar.open(
      IsarSchemes.list,
      name: fileNameWithoutExtension,
      directory: directoryPath,
    );
  }

  Future<void> restoreDB() async {
    final isar = _database;
    // final dbDirectory = await getApplicationDocumentsDirectory();
    //final backupDirectory = await getApplicationSupportDirectory();
    const path1 = '/storage/emulated/0/Download/Isar/db';
    final dbDirectory = Directory(path1);
    const path = '/storage/emulated/0/Download/Isar/backup/';
    final backupDirectory = Directory(path);

    // close the database before any changes
    await isar!.close();

    final dbFile = File('${backupDirectory.path}/backup_db.isar');
    final dbPath = p.join(dbDirectory.path, 'default.isar');

    if (await dbFile.exists()) {
      // here we overwrite the backup file on the database file
      await dbFile.copy(dbPath);
    }
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
      throw DatabaseException();
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
      throw DatabaseException();
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
      throw DatabaseException();
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
      throw DatabaseException();
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
      throw DatabaseException();
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
      throw DatabaseException();
    }
  }

  /// Get a Collection from Isar
  Future<IsarCollection<T>> get<T>() async {
    try {
      final collection = _database!.collection<T>();
      return collection;
    } catch (e) {
      log('EXCEPTION DATABASE $T ===> $e');
      throw DatabaseException();
    }
  }

  /// Get a Collection from Isar
  Future<List<T>> getAll<T>() async {
    try {
      final collection = _database!.collection<T>();
      return collection.where().findAll();
    } catch (e) {
      log('EXCEPTION DATABASE $T ===> $e');
      throw DatabaseException();
    }
  }

  /*Future<void> clearAll<T>() async {
    try {
      final collection = _database.collection<T>();
      final count = await collection.count();
      if (count != 0) await collection.de();
    } catch (e) {
      log('EXCEPTION DATABASE $T ===> $e');
      throw DatabaseException();
    }
  }*/

  Future<List<T>> getAllByFilter<T>() async {
    try {
      final collection = _database!.collection<T>();
      return collection.where().findAll();
    } catch (e) {
      log('EXCEPTION DATABASE $T ===> $e');
      throw DatabaseException();
    }
  }
}
