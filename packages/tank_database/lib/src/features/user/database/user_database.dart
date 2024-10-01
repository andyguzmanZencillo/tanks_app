import 'package:failures/failures.dart';
import 'package:isar/isar.dart';
import 'package:tank_database/tank_database.dart';

class UserDatabase {
  UserDatabase({
    Database? database,
  }) : _database = database ?? Database.instance;

  final Database _database;

  Future<void> saveUsers({
    required List<UserCollection> users,
  }) async {
    try {
      await _database.clearAndSaveMany<UserCollection>(users);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearUser({required int id}) async {
    try {
      await _database.clear<UserCollection>(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveUser({
    required UserCollection user,
  }) async {
    try {
      await _database.clearAndSave<UserCollection>(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCollection> getUserByIdEmploye({
    required int idEmploye,
  }) async {
    try {
      final all = await _database.getAll<UserCollection>();
      if (all.isEmpty) {
        throw const ResultException(
          'No hay empleados configurados...',
        );
      }
      final user = await _database.get<UserCollection>();
      final login =
          await user.filter().idEmployeeEqualTo(idEmploye).findFirst();

      return login!;
    } catch (e) {
      if (e is TypeError) throw NotFoundException();
      rethrow;
    }
  }

  Future<UserCollection> getUser() async {
    try {
      final all = await _database.getAll<UserCollection>();
      if (all.isEmpty) {
        throw const DataNullException(
          'No hay usuarios guardados',
        );
      }
      return await _database.getById<UserCollection>(1);
    } catch (e) {
      if (e is TypeError) throw NotFoundException();
      rethrow;
    }
  }
}
