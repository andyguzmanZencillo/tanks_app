import 'package:tank_api/tank_api.dart';
import 'package:tank_repository/features/user_device/user_device.dart';

extension MapperUserDeviceReponseToEntity on UserDeviceResponse {
  UserDeviceEntity toEntity() {
    return UserDeviceEntity(
      token: token,
      idUsuario: idUsuario,
      dispositivo: dispositivo,
      idCompania: idCompania,
      idUsuarioDispositivo: idUsuarioDispositivo,
    );
  }
}
