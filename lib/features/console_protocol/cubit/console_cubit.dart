import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/helpers/dialog_info.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/features/console_protocol/helpers/message_console_protocol_listener.dart';

part 'console_state.dart';

class ConsoleProtocolCubit extends Cubit<ConsoleProtocolState> {
  ConsoleProtocolCubit(this.consoleRepository)
      : super(const ConsoleProtocolState());

  final ConsoleRepository consoleRepository;
  void onChangedSelected(ConsoleProtocolEntity consoleEntity) {
    emit(state.copyWith(selected: consoleEntity));
  }

  Future<bool> getAll() async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageConsoleProtocolListener.loadingGet,
      ),
    );
    final result = await consoleRepository.getProtocolAll();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            list: ok,
            listCopy: ok,
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageConsoleProtocolListener.successGet,
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
              dialogMessage: MessageConsoleProtocolListener.error,
            ),
          );
        }
      },
    );
    return result.isOk();
  }
}
