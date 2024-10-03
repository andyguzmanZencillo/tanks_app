import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'upsert_capacity_table_state.dart';

class UpsertCapacityTableCubit extends Cubit<UpsertCapacityTableState> {
  UpsertCapacityTableCubit(this.tanksRepository)
      : super(const UpsertCapacityTableState());
  final CapacityTableRepository tanksRepository;

  Future<void> create({
    required int idTanque,
    required String alturaTanque,
    required String volumen,
  }) async {
    emit(state.copyWith(upsertStatus: UpsertStatus.loading));
    final result = await tanksRepository.saveCapacityTable(
      CapacityTableEntity(
        idAforo: 0,
        idTanque: idTanque,
        idCompania: 1,
        alturaTanque: double.parse(alturaTanque),
        volumen: double.parse(volumen),
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
        emit(state.copyWith(upsertStatus: UpsertStatus.error));
      },
    );
  }

  Future<void> update({
    required CapacityTableEntity tanksEntity,
    required int idTanque,
    required String alturaTanque,
    required String volumen,
  }) async {
    emit(state.copyWith(upsertStatus: UpsertStatus.loading));
    final result = await tanksRepository.updateCapacityTable(
      tanksEntity.copyWith(
        idTanque: idTanque,
        alturaTanque: double.parse(alturaTanque),
        volumen: double.parse(volumen),
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
