import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/features/sales_center/sales_center.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'upsert_console_states.dart';

class UpsertConsoleCubit extends Cubit<UpsertConsoleState> {
  UpsertConsoleCubit(this.salesCenterRepository)
      : super(const UpsertConsoleState());
  final SalesCenterRepository salesCenterRepository;

  Future<void> create({
    required String centroVenta,
    required String descripcion,
    required String correo,
  }) async {
    emit(state.copyWith(upsertStatus: UpsertStatus.loading));
    final result = await salesCenterRepository.saveSalesCenter(
      SalesCenterEntity(
        idCentroVenta: 0,
        idCompania: 0,
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
  }

  Future<void> updateArticle({
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
  }
}
