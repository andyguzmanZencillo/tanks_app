import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/features/features.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'upsert_tank_variation_states.dart';

class UpsertTankVariationCubit extends Cubit<UpsertTankVariationState> {
  UpsertTankVariationCubit(
    this.tankVariationRepository,
  ) : super(const UpsertTankVariationState());

  final TankVariationRepository tankVariationRepository;

  Future<void> create({
    required TankVariationEntity tankVariationEntity,
  }) async {
    emit(state.copyWith(upsertStatus: UpsertStatus.loading));
    final result = await tankVariationRepository.saveTankVariation(
      tankVariationEntity,
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

  /*Future<void> updateArticle({
    required SalesCenterEntity salesCenterEntity,
    required String centroVenta,
    required String descripcion,
    required String correo,
  }) async {
    emit(state.copyWith(upsertStatus: UpsertStatus.loading));
    final result = await salesCenterRepository.updateSalesCenter(
      salesCenterEntity.copyWith(
        centroVenta: centroVenta,
        descripcion: descripcion,
        correo: correo,
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
  }*/

  double searchAforo({
    required List<CapacityEntity> capacityEntitys,
    required double rValorBuscado,
  }) {
    if (capacityEntitys.isEmpty) return 0;

    final initial = capacityEntitys.first.alturaTanque;
    final last = capacityEntitys.last.alturaTanque;

    if (!(rValorBuscado >= initial && rValorBuscado <= last)) return 0;

    final v = capacityEntitys
        .firstWhereOrNull((element) => element.alturaTanque == rValorBuscado);
    if (v != null) {
      return v.volumen;
    }

    final resultValorInferior = valorInferior(
      aforos: capacityEntitys,
      rValorBuscado: rValorBuscado,
    );
    final rNVolAforoInf = resultValorInferior.$1;
    final rNAltAforoInf = resultValorInferior.$2;

    final resultValorSuperior = valorSuperior(
      aforos: capacityEntitys,
      rValorBuscado: rValorBuscado,
    );

    final rNVolAforoSup = resultValorSuperior.$1;
    final rNAltAforoSup = resultValorSuperior.$2;

    if (rNAltAforoInf == 0 || rNAltAforoSup == 0) {
      return 0;
    }

    final alturaDif = rNAltAforoSup - rNAltAforoInf;
    final volDif = rNVolAforoSup - rNVolAforoInf;
    final proporcion = (rValorBuscado - rNAltAforoInf) / alturaDif;

    return rNVolAforoInf + proporcion * volDif;
  }

  (double, double) valorInferior({
    required List<CapacityEntity> aforos,
    required double rValorBuscado,
  }) {
    var rAlturaMinProx = 0.0;
    var rVolMinProx = 0.0;
    var diferencia = 99999999.0;

    for (final vAforoinf in aforos) {
      final rTempDiferencia = rValorBuscado - vAforoinf.alturaTanque;
      if (rTempDiferencia >= 0 && rTempDiferencia < diferencia) {
        diferencia = rTempDiferencia;
        rAlturaMinProx = vAforoinf.alturaTanque;
        rVolMinProx = vAforoinf.volumen;
      }
    }
    return (rVolMinProx, rAlturaMinProx);
  }

  (double, double) valorSuperior({
    required List<CapacityEntity> aforos,
    required double rValorBuscado,
  }) {
    var rAlturaMinProx = 0.0;
    var rVolMinProx = 0.0;
    var diferencia = 99999999.0;

    for (final vAforoinf in aforos) {
      log('Altura encontrada: ${vAforoinf.alturaTanque}');
      log('Valor Buscado: $rValorBuscado');

      final rTempDiferencia = vAforoinf.alturaTanque - rValorBuscado;
      log('Diferencia: $rTempDiferencia');

      if (rTempDiferencia >= 0 && rTempDiferencia < diferencia) {
        log('Set new difference: $rTempDiferencia');
        diferencia = rTempDiferencia;
        rAlturaMinProx = vAforoinf.alturaTanque;
        rVolMinProx = vAforoinf.volumen;
      }
    }

    return (rVolMinProx, rAlturaMinProx);
  }
}
