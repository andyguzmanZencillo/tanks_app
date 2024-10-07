import 'package:tank_api/tank_api.dart';
import 'package:tank_repository/features/config/entity/config_entity.dart';

extension MapperConfigResponseToEntity on ConfigResponse {
  ConfigEntity toEntity() {
    return ConfigEntity(
      idCompania: idCompania,
      idConfiguracion: idConfiguracion,
      horaInicioZeta: horaInicioZeta,
      horaFinZeta: horaFinZeta,
    );
  }
}
