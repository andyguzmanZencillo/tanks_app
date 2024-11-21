import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/helpers/dialog_info.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/features/console/helpers/message_console_listener.dart';

part 'console_state.dart';

class ConsoleCubit extends Cubit<ConsoleState> {
  ConsoleCubit(this.consoleRepository) : super(const ConsoleState());

  final ConsoleRepository consoleRepository;
  void onChangedSelected(ConsoleEntity consoleEntity) {
    emit(state.copyWith(selected: consoleEntity));
  }

  void changeSort(Sort sort) {
    final sortedItems = sortList(sort, state.list);
    emit(state.copyWith(sort: sort, list: sortedItems));
  }

  List<ConsoleEntity> sortList(Sort sort, List<ConsoleEntity> list) {
    final sortedItems = List<ConsoleEntity>.from(list);
    sortedItems.sort((a, b) {
      if (sort == Sort.asc) {
        return a.consola.compareTo(b.consola);
      } else {
        return b.consola.compareTo(a.consola);
      }
    });
    return sortedItems;
  }

  Future<bool> getAll() async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageConsoleListener.loadingGet,
      ),
    );
    final result = await consoleRepository.getAll();
    result.when(
      ok: (ok) {
        final sortedItems = sortList(state.sort, ok);
        emit(
          state.copyWith(
            list: sortedItems,
            listCopy: sortedItems,
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageConsoleListener.successGet,
          ),
        );
      },
      err: (err) {
        if (err is InvalidDataFailure) {
          emit(
            state.copyWith(
              generalStatus: GeneralStatus.error,
              list: [],
              listCopy: [],
              dialogMessage: DialogMessage(message: err.message),
            ),
          );
        } else {
          emit(
            state.copyWith(
              generalStatus: GeneralStatus.error,
              list: [],
              listCopy: [],
              dialogMessage: MessageConsoleListener.error,
            ),
          );
        }
      },
    );
    return result.isOk();
  }

  void search(String text) {
    final listCopy = [...state.listCopy];
    final listSearh = listCopy
        .where(
          (element) =>
              element.consola.toLowerCase().contains(text.toLowerCase()),
        )
        .toList();
    final sortedItems = sortList(state.sort, listSearh);
    emit(state.copyWith(list: sortedItems));
  }

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
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageConsoleListener.loadingCreate,
      ),
    );
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
        emit(
          state.copyWith(
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageConsoleListener.successCreate,
          ),
        );
      },
      err: (err) {
        if (err is InvalidDataFailure) {
          emit(
            state.copyWith(
              generalStatus: GeneralStatus.error,
              dialogMessage: DialogMessage(message: err.message),
            ),
          );
        } else {
          emit(
            state.copyWith(
              generalStatus: GeneralStatus.error,
              dialogMessage: MessageConsoleListener.error,
            ),
          );
        }
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
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageConsoleListener.loadingUpdate,
      ),
    );
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
        emit(
          state.copyWith(
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageConsoleListener.successUpdate,
          ),
        );
      },
      err: (err) {
        if (err is InvalidDataFailure) {
          emit(
            state.copyWith(
              generalStatus: GeneralStatus.error,
              dialogMessage: DialogMessage(message: err.message),
            ),
          );
        } else {
          emit(
            state.copyWith(
              generalStatus: GeneralStatus.error,
              dialogMessage: MessageConsoleListener.error,
            ),
          );
        }
      },
    );
  }

  Future<void> delete(int idArticle) async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageConsoleListener.loadingDelete,
      ),
    );
    final result = await consoleRepository.deleteConsole(idArticle);
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageConsoleListener.successDelete,
          ),
        );
      },
      err: (err) {
        if (err is InvalidDataFailure) {
          emit(
            state.copyWith(
              generalStatus: GeneralStatus.error,
              dialogMessage: DialogMessage(message: err.message),
            ),
          );
        } else {
          emit(
            state.copyWith(
              generalStatus: GeneralStatus.error,
              dialogMessage: MessageConsoleListener.error,
            ),
          );
        }
      },
    );
  }
}
