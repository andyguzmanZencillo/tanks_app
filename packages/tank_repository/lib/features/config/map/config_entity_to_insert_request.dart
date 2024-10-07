import 'package:tank_api/tank_api.dart';
import 'package:tank_repository/features/config/entity/config_entity.dart';

extension MapperConfigEntityToRequest on ConfigEntity {
  InsertConfigRequest toInsertRequest() {
    return InsertConfigRequest(
      idCompania: idCompania,
      horaInicioZeta: horaInicioZeta,
      horaFinZeta: horaFinZeta,
    );
  }
}
