import 'package:tank_api/tank_api.dart';
import 'package:tank_repository/features/user_device/entity/user_alert_entity.dart';

extension MapperUserAlertResponseToEntity on UserAlertResponse {
  UserAlertEntity toEntity() {
    return UserAlertEntity(
      idAlerta: idAlerta,
      idUsuario: idUsuario,
      idCompania: idCompania,
      idUsuarioAlerta: idUsuarioAlerta,
    );
  }
}
