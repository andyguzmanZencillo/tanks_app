import 'package:tank_api/tank_api.dart';
import 'package:tank_repository/features/config/entity/config_entity.dart';

extension MapperConfigEntityToRequest on ConfigEntity {
  UpdateConfigRequest toUpdateRequest() {
    return UpdateConfigRequest(
      idCompania: idCompania,
      idConfiguracion: idConfiguracion,
      horaInicioZeta: horaInicioZeta,
      horaFinZeta: horaFinZeta,
    );
  }
}
