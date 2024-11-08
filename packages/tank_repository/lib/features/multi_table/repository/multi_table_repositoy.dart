import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/tank_api.dart';
import 'package:tank_database/tank_database.dart';
import 'package:tank_repository/core/generic_token.dart';
import 'package:tank_repository/features/article/article.dart';
import 'package:tank_repository/features/console/mapper/console_response_to_entity.dart';
import 'package:tank_repository/features/features.dart';
import 'package:tank_repository/features/multi_table/entity/multi_table_entity.dart';

class MultiTableRepository {
  MultiTableRepository({
    MultiTableApi? api,
    UserDatabase? userDatabase,
  })  : _userDatabase = userDatabase ?? UserDatabase(),
        _api = api ?? MultiTableApi();

  final MultiTableApi _api;
  final UserDatabase _userDatabase;

  Future<Result<MultiTableEntity, Failure>> getAll() {
    return handleExceptionCompleteToken<MultiTableEntity>(() async {
      final user = await _userDatabase.getUser();
      final request = GetCentroVentaArticuloConsolaRequest(
        idCompania: user.idCompany,
        idUsuario: user.idEmployee,
      );
      final response = await _api.getCentroArticuloConsola(request);
      return MultiTableEntity(
        articles: response.articles.map((e) => e.toEntity()).toList(),
        salesCenter: response.salesCenter.map((e) => e.toEntity()).toList(),
        consoles: response.consoles.map((e) => e.toEntity()).toList(),
      );
    });
  }
}
