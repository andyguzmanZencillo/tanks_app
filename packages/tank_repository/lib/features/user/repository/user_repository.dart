import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/features/user/api/user_api.dart';
import 'package:tank_api/features/user/models/user_request.dart';
import 'package:tank_repository/core/generic_token.dart';

class UserRepository {
  UserRepository({
    UserApi? api,
  }) : _api = api ?? UserApi();

  final UserApi _api;

  Future<Result<Unit, Failure>> signIn({
    required int idCompany,
    required String user,
    required String password,
  }) {
    return handleExceptionToken<Unit>(() async {
      final request = SignInUserRequest(
        nombre: user,
        clave: password,
        idCompania: idCompany,
      );
      await _api.getUserToSignIn(request);
      return unit;
    });
  }

  Future<Result<Unit, Failure>> signUp({
    required int idCompany,
    required String user,
    required String password,
  }) {
    return handleExceptionToken<Unit>(() async {
      final request = InsertUserRequest(
        idCompania: idCompany,
        nombre: user,
        clave: password,
      );
      await _api.insertUser(request);
      return unit;
    });
  }
}
