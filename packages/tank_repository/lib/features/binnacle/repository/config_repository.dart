import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/tank_api.dart';
import 'package:tank_database/tank_database.dart';
import 'package:tank_repository/core/generic_token.dart';
import 'package:tank_repository/features/binnacle/entity/binnacle_entity.dart';
import 'package:tank_repository/features/binnacle/map/binnacle_response_to_entity.dart';

class BinnacleRepository {
  BinnacleRepository({
    BinnacleApi? api,
    UserDatabase? userDatabase,
  })  : _userDatabase = userDatabase ?? UserDatabase(),
        _api = api ?? BinnacleApi();

  final BinnacleApi _api;
  final UserDatabase _userDatabase;

  Future<Result<List<BinnacleEntity>, Failure>> getAll() {
    return handleExceptionCompleteToken<List<BinnacleEntity>>(() async {
      final user = await _userDatabase.getUser();
      final request = GetBinnacleRequest(
        idCompania: user.idCompany,
      );
      final response = await _api.getAll(request);
      return response
          .map(
            (e) => e.toEntity(),
          )
          .toList();
    });
  }
}
