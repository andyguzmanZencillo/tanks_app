import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'config_state.dart';

class ConfigCubit extends Cubit<ConfigState> {
  ConfigCubit(this.consoleRepository) : super(const ConfigState());

  final ConfigRepository consoleRepository;

  void changeSelected(ConfigEntity configSelected) {
    emit(state.copyWith(configSelected: configSelected));
  }

  Future<void> getAll() async {
    emit(state.copyWith(generalStatus: GeneralStatus.loading));
    final result = await consoleRepository.getAll();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            configurations: ok,
            generalStatus: GeneralStatus.success,
          ),
        );
      },
      err: (err) {
        if (err is ResultFailure) {
          emit(
            state.copyWith(
              configurations: [],
              generalStatus: GeneralStatus.error,
              errorMessage: err.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              configurations: [],
              generalStatus: GeneralStatus.error,
              errorMessage: 'Error desconocido',
            ),
          );
        }
      },
    );
  }
}
