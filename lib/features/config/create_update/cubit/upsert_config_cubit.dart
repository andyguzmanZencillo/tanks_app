import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/features/features.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'upsert_config_states.dart';

class UpsertConfigCubit extends Cubit<UpsertConfigState> {
  UpsertConfigCubit(
    this.configRepository,
  ) : super(const UpsertConfigState());

  final ConfigRepository configRepository;

  Future<void> create({
    required String horaInicial,
    required String horaFinal,
  }) async {
    emit(state.copyWith(upsertStatus: UpsertStatus.loading));
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
        emit(state.copyWith(upsertStatus: UpsertStatus.success));
      },
      err: (err) {
        if (err is ResultFailure) {
          emit(
            state.copyWith(
              upsertStatus: UpsertStatus.error,
              errorMessage: err.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              upsertStatus: UpsertStatus.error,
              errorMessage: 'Error desconocido',
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
    emit(state.copyWith(upsertStatus: UpsertStatus.loading));
    final result = await configRepository.updateConfig(
      configEntity.copyWith(
        horaInicioZeta: horaInicial,
        horaFinZeta: horaFinal,
      ),
    );
    result.when(
      ok: (ok) {
        emit(state.copyWith(upsertStatus: UpsertStatus.success));
      },
      err: (err) {
        if (err is ResultFailure) {
          emit(
            state.copyWith(
              upsertStatus: UpsertStatus.error,
              errorMessage: err.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              upsertStatus: UpsertStatus.error,
              errorMessage: 'Error desconocido',
            ),
          );
        }
      },
    );
  }
}
