import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'upsert_tanks_state.dart';

class UpsertTanksCubit extends Cubit<UpsertTanksState> {
  UpsertTanksCubit(this.tanksRepository) : super(const UpsertTanksState());
  final TanksRepository tanksRepository;

  Future<void> create({
    required int idCentroVenta,
    required int idArticulo,
    required String capacidad,
    required String alturaTanque,
    required String descripcion,
    required String porcentajeMinimoCombustible,
    required String alturaOffset,
    required String factorInicioDescargue,
    required String codigo,
    required double alturaAguaOffset,
    required double offsetInclinacion,
    required bool estado,
    required bool modificable,
    required bool manejaMm,
    required int idConsolaTanque,
  }) async {
    emit(state.copyWith(upsertStatus: UpsertStatus.loading));
    final result = await tanksRepository.saveTanks(
      TanksEntity(
        idTanque: 0,
        idCompania: 1,
        idCentroVenta: idCentroVenta,
        idArticulo: idArticulo,
        capacidad: double.parse(capacidad),
        alturaTanque: double.parse(alturaTanque),
        descripcion: descripcion,
        porcentajeMinimoCombustible: double.parse(porcentajeMinimoCombustible),
        alturaOffset: double.parse(alturaOffset),
        factorInicioDescargue: double.parse(factorInicioDescargue),
        codigo: int.parse(codigo),
        alturaAguaOffset: alturaAguaOffset,
        offsetInclinacion: offsetInclinacion,
        estado: estado,
        modificable: modificable,
        manejaMm: manejaMm,
        idConsolaTanque: idConsolaTanque,
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
    required TanksEntity tanksEntity,
    required int idCentroVenta,
    required int idArticulo,
    required String capacidad,
    required String alturaTanque,
    required String descripcion,
    required String porcentajeMinimoCombustible,
    required String alturaOffset,
    required String factorInicioDescargue,
    required String codigo,
    required String alturaAguaOffset,
    required String offsetInclinacion,
    required bool estado,
    required bool modificable,
    required bool manejaMm,
    required int idConsolaTanque,
  }) async {
    emit(state.copyWith(upsertStatus: UpsertStatus.loading));
    final result = await tanksRepository.updateTanks(
      tanksEntity.copyWith(
        idCentroVenta: idCentroVenta,
        idArticulo: idArticulo,
        capacidad: double.parse(capacidad),
        alturaTanque: double.parse(alturaTanque),
        descripcion: descripcion,
        porcentajeMinimoCombustible: double.parse(porcentajeMinimoCombustible),
        alturaOffset: double.parse(alturaOffset),
        factorInicioDescargue: double.parse(factorInicioDescargue),
        codigo: int.parse(codigo),
        alturaAguaOffset: double.parse(alturaAguaOffset),
        offsetInclinacion: double.parse(offsetInclinacion),
        estado: estado,
        modificable: modificable,
        manejaMm: manejaMm,
        idConsolaTanque: idConsolaTanque,
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

  Future<void> functionState(
    Future<(bool, String?)> Function() function,
  ) async {
    emit(state.copyWith(prepareStatus: PrepareStatus.loading));

    final result = await function();

    if (result.$1) {
      emit(state.copyWith(prepareStatus: PrepareStatus.success));
    } else {
      emit(
        state.copyWith(
          prepareStatus: PrepareStatus.error,
          errorMessage: result.$2,
        ),
      );
    }
  }
}
