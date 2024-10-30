import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/tank_api.dart';
import 'package:tank_database/tank_database.dart';
import 'package:tank_repository/core/generic_token.dart';

class TokenRepository {
  TokenRepository({
    TokenApi? api,
    UserDatabase? userDatabase,
  })  : _userDatabase = userDatabase ?? UserDatabase(),
        _api = api ?? TokenApi();

  final TokenApi _api;
  final UserDatabase _userDatabase;

  Future<Result<Unit, Failure>> getToken({
    required String idCompany,
    required String user,
    required String password,
  }) {
    return handleExceptionCompleteToken<Unit>(() async {
      await _api.getToken(
        idCompany: idCompany,
        user: user,
        password: password,
      );
      return unit;
    });
  }

  Future<Result<Unit, Failure>> generateToken() {
    return handleExceptionCompleteToken<Unit>(() async {
      final user = await _userDatabase.getUser();
      await _api.getToken(
        idCompany: user.idCompany.toString(),
        user: user.login,
        password: user.password,
      );
      return unit;
    });
  }
}
