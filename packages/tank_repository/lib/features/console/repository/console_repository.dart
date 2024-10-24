import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/tank_api.dart';
import 'package:tank_database/tank_database.dart';
import 'package:tank_repository/core/generic_token.dart';
import 'package:tank_repository/features/console/entity/console_entity.dart';

class ConsoleRepository {
  ConsoleRepository({
    ConsoleApi? api,
    UserDatabase? userDatabase,
  })  : _userDatabase = userDatabase ?? UserDatabase(),
        _api = api ?? ConsoleApi();

  final ConsoleApi _api;
  final UserDatabase _userDatabase;

  Future<Result<List<ConsoleEntity>, Failure>> getAll() {
    return handleExceptionCompleteToken<List<ConsoleEntity>>(() async {
      final request = GetConsoleRequest(
        idCompania: 1,
      );
      final response = await _api.getAll(request);
      return response
          .map(
            (e) => ConsoleEntity(
              idConsola: e.idConsola,
              idCompania: e.idCompania,
              consola: e.consola,
              descripcion: e.descripcion,
              idConsolaTanqueProtocolo: e.idConsolaTanqueProtocolo,
              tipo: e.tipo,
              ip: e.ip,
              socket: e.socket,
              puertoSerial: e.puertoSerial,
              contrasenaIp: e.contrasenaIp,
            ),
          )
          .toList();
    });
  }

  Future<Result<bool, Failure>> saveConsole(
    ConsoleEntity consoleEntity,
  ) {
    return handleExceptionCompleteToken<bool>(() async {
      final user = await _userDatabase.getUser();
      final request = InsertConsoleRequest(
        idCompania: user.idCompany,
        console: consoleEntity.consola,
        description: consoleEntity.descripcion,
        idConsoleTankProtocol: consoleEntity.idConsolaTanqueProtocolo,
        type: consoleEntity.tipo,
        ip: consoleEntity.ip,
        socket: consoleEntity.socket,
        portSerial: consoleEntity.puertoSerial,
        passWordIp: consoleEntity.contrasenaIp,
      );
      final response = await _api.save(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> updateConsole(
    ConsoleEntity consoleEntity,
  ) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = UpdateConsoleRequest(
        idConsole: consoleEntity.idConsola,
        idCompania: consoleEntity.idCompania,
        console: consoleEntity.consola,
        description: consoleEntity.descripcion,
        idConsoleTankProtocol: consoleEntity.idConsolaTanqueProtocolo,
        type: consoleEntity.tipo,
        ip: consoleEntity.ip,
        socket: consoleEntity.socket,
        portSerial: consoleEntity.puertoSerial,
        passWordIp: consoleEntity.contrasenaIp,
      );
      final response = await _api.update(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> deleteConsole(int idConsole) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = DeleteConsoleRequest(
        idConsole: idConsole,
        idCompania: 1,
      );
      final response = await _api.delete(request);
      return true;
    });
  }
}
