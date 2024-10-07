import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/tank_api.dart';
import 'package:tank_database/tank_database.dart';
import 'package:tank_repository/core/generic_token.dart';
import 'package:tank_repository/features/config/entity/config_entity.dart';
import 'package:tank_repository/features/config/map/config_entity_to_insert_request.dart';
import 'package:tank_repository/features/config/map/config_entity_to_update_request.dart';
import 'package:tank_repository/features/config/map/config_response_to_entity.dart';

class ConfigRepository {
  ConfigRepository({
    ConfigApi? api,
    UserDatabase? userDatabase,
  })  : _userDatabase = userDatabase ?? UserDatabase(),
        _api = api ?? ConfigApi();

  final ConfigApi _api;
  final UserDatabase _userDatabase;

  Future<Result<List<ConfigEntity>, Failure>> getAll() {
    return handleExceptionCompleteToken<List<ConfigEntity>>(() async {
      final request = GetConfigRequest(
        idCompania: 1,
      );
      final response = await _api.getAll(request);
      return response
          .map(
            (e) => e.toEntity(),
          )
          .toList();
    });
  }

  Future<Result<bool, Failure>> saveConfig(
    ConfigEntity e,
  ) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = e.toInsertRequest();
      final response = await _api.save(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> updateConfig(
    ConfigEntity e,
  ) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = e.toUpdateRequest();
      final response = await _api.update(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> deleteConfig(int idConfig) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = DeleteConfigRequest(
        idConfiguracion: idConfig,
        idCompania: 1,
      );
      final response = await _api.delete(request);
      return true;
    });
  }
}
