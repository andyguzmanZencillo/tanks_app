import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/features/user/api/user_api.dart';
import 'package:tank_api/features/user/models/user_request.dart';
import 'package:tank_database/tank_database.dart';
import 'package:tank_repository/core/generic_token.dart';
import 'package:tank_repository/features/user/entities/user_entity.dart';
import 'package:tank_repository/features/user/mappers/user_collection_to_entity.dart';

class UserRepository {
  UserRepository({
    UserApi? api,
    UserDatabase? userDatabase,
  })  : _userDatabase = userDatabase ?? UserDatabase(),
        _api = api ?? UserApi();

  final UserApi _api;
  final UserDatabase _userDatabase;

  Future<Result<UserEntity, Failure>> getUser() {
    return handleExceptionsLocal<UserEntity>(() async {
      final collection = await _userDatabase.getUser();

      return collection.toEntity();
    });
  }

  Future<Result<Unit, Failure>> removeUser() {
    return handleExceptionsLocal<Unit>(() async {
      await _userDatabase.clear();
      return unit;
    });
  }

  Future<Result<Unit, Failure>> signIn({
    required int idCompany,
    required String user,
    required String password,
  }) {
    return handleExceptionToken<Unit>(() async {
      final request = SignInUserRequest(
        usuario: user,
        clave: password,
        idCompania: idCompany,
      );
      final result = await _api.getUserToSignIn(request);

      await _userDatabase.saveUser(
        user: UserCollection(
          idCompany: result.idCompania,
          idEmployee: result.idUsuario,
          login: result.usuario,
          password: result.clave,
          name: result.nombre,
        ),
      );

      return unit;
    });
  }

  Future<Result<Unit, Failure>> signUp({
    required int idCompany,
    required String user,
    required String password,
    required String name,
  }) {
    return handleExceptionCompleteToken<Unit>(() async {
      final request = InsertUserRequest(
        idCompania: idCompany,
        nombre: name,
        usuario: user,
        clave: password,
      );
      final result = await _api.insertUser(request);

      await _userDatabase.saveUser(
        user: UserCollection(
          idCompany: idCompany,
          idEmployee: result,
          login: user,
          password: password,
          name: user,
        ),
      );
      return unit;
    });
  }

  Future<Result<UserEntity, Failure>> verification() {
    return handleExceptionsLocal<UserEntity>(() async {
      final response = await _userDatabase.getUser();

      return UserEntity(
        idCompany: response.idCompany,
        idEmployee: response.idEmployee,
        login: response.login,
        password: response.password,
        name: response.name,
        idIsar: response.id,
      );
    });
  }
}
