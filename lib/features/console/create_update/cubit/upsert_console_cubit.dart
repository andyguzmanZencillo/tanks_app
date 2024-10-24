import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/features/features.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'upsert_console_states.dart';

class UpsertConsoleCubit extends Cubit<UpsertConsoleState> {
  UpsertConsoleCubit(this.consoleRepository)
      : super(const UpsertConsoleState());
  final ConsoleRepository consoleRepository;

  Future<void> create({
    required String consola,
    required String descripcion,
    required int idConsolaTanqueProtocolo,
    required String tipo,
    required String ip,
    required String socket,
    required String puertoSerial,
    required String contrasenaIp,
  }) async {
    emit(state.copyWith(upsertStatus: UpsertStatus.loading));
    final result = await consoleRepository.saveConsole(
      ConsoleEntity(
        idConsola: 0,
        idCompania: 0,
        consola: consola,
        descripcion: descripcion,
        idConsolaTanqueProtocolo: idConsolaTanqueProtocolo,
        tipo: tipo,
        ip: ip,
        socket: socket,
        puertoSerial: puertoSerial,
        contrasenaIp: contrasenaIp,
      ),
    );

    result.when(
      ok: (ok) {
        emit(state.copyWith(upsertStatus: UpsertStatus.success));
      },
      err: (err) {
        emit(state.copyWith(upsertStatus: UpsertStatus.error));
      },
    );
  }

  Future<void> updateArticle({
    required ConsoleEntity consoleEntity,
    required String consola,
    required String descripcion,
    required int idConsolaTanqueProtocolo,
    required String tipo,
    required String ip,
    required String socket,
    required String puertoSerial,
    required String contrasenaIp,
  }) async {
    emit(state.copyWith(upsertStatus: UpsertStatus.loading));
    final result = await consoleRepository.updateConsole(
      consoleEntity.copyWith(
        consola: consola,
        descripcion: descripcion,
        idConsolaTanqueProtocolo: idConsolaTanqueProtocolo,
        tipo: tipo,
        ip: ip,
        socket: socket,
        puertoSerial: puertoSerial,
        contrasenaIp: contrasenaIp,
      ),
    );

    result.when(
      ok: (ok) {
        emit(state.copyWith(upsertStatus: UpsertStatus.success));
      },
      err: (err) {
        emit(state.copyWith(upsertStatus: UpsertStatus.error));
      },
    );
  }
}
