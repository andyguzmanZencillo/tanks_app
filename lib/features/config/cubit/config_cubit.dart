import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/helpers/dialog_info.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/features/config/helpers/message_config_listener.dart';

part 'config_state.dart';

class ConfigCubit extends Cubit<ConfigState> {
  ConfigCubit(this.configRepository) : super(const ConfigState());

  final ConfigRepository configRepository;

  void changeSelected(ConfigEntity configSelected) {
    emit(state.copyWith(configSelected: configSelected));
  }

  Future<void> getAll() async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageConfigListener.loading,
      ),
    );
    final result = await configRepository.getAll();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            configurations: ok,
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageConfigListener.successLoad,
          ),
        );
      },
      err: (err) {
        if (err is InvalidDataFailure) {
          emit(
            state.copyWith(
              configurations: [],
              generalStatus: GeneralStatus.error,
              dialogMessage: DialogMessage(message: err.message),
            ),
          );
        } else {
          emit(
            state.copyWith(
              configurations: [],
              generalStatus: GeneralStatus.error,
              dialogMessage: MessageConfigListener.error,
            ),
          );
        }
      },
    );
  }

  Future<void> create({
    required String horaInicial,
    required String horaFinal,
  }) async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageConfigListener.loadingCreate,
      ),
    );
    final result = await configRepository.saveConfig(
      ConfigEntity(
        idCompania: 1,
        idConfiguracion: 0,
        horaInicioZeta: horaInicial,
        horaFinZeta: horaFinal,
      ),
    );
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageConfigListener.successCreate,
          ),
        );
      },
      err: (err) {
        if (err is InvalidDataFailure) {
          emit(
            state.copyWith(
              configurations: [],
              generalStatus: GeneralStatus.error,
              dialogMessage: DialogMessage(message: err.message),
            ),
          );
        } else {
          emit(
            state.copyWith(
              configurations: [],
              generalStatus: GeneralStatus.error,
              dialogMessage: MessageConfigListener.error,
            ),
          );
        }
      },
    );
  }

  Future<void> update({
    required ConfigEntity configEntity,
    required String horaInicial,
    required String horaFinal,
  }) async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageConfigListener.loadingUpdate,
      ),
    );
    final result = await configRepository.updateConfig(
      configEntity.copyWith(
        horaInicioZeta: horaInicial,
        horaFinZeta: horaFinal,
      ),
    );
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageConfigListener.successUpdate,
          ),
        );
      },
      err: (err) {
        if (err is InvalidDataFailure) {
          emit(
            state.copyWith(
              configurations: [],
              generalStatus: GeneralStatus.error,
              dialogMessage: DialogMessage(message: err.message),
            ),
          );
        } else {
          emit(
            state.copyWith(
              configurations: [],
              generalStatus: GeneralStatus.error,
              dialogMessage: MessageConfigListener.error,
            ),
          );
        }
      },
    );
  }
}
