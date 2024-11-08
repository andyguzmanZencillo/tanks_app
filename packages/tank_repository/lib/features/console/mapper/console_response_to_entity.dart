import 'package:tank_api/tank_api.dart';
import 'package:tank_repository/features/console/entity/console_entity.dart';

extension ConsoleResponseToEntity on ConsoleResponse {
  ConsoleEntity toEntity() {
    return ConsoleEntity(
      idConsola: idConsola,
      idCompania: idCompania,
      consola: consola,
      descripcion: descripcion,
      idConsolaTanqueProtocolo: idConsolaTanqueProtocolo,
      tipo: tipo,
      ip: ip,
      socket: socket,
      puertoSerial: puertoSerial,
      contrasenaIp: contrasenaIp,
    );
  }
}
