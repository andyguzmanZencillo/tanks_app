import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/features/sales_center/sales_center.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'upsert_sales_center_states.dart';

class UpsertSalesCenterCubit extends Cubit<UpsertSalesCenterState> {
  UpsertSalesCenterCubit(this.salesCenterRepository)
      : super(const UpsertSalesCenterState());
  final SalesCenterRepository salesCenterRepository;

  Future<void> create({
    required String centroVenta,
    required String descripcion,
    required String correo,
  }) async {
    emit(state.copyWith(createUpdateStatus: UpsertStatus.loading));
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
        emit(state.copyWith(createUpdateStatus: UpsertStatus.success));
      },
      err: (err) {
        if (err is ResultFailure) {
          emit(
            state.copyWith(
              createUpdateStatus: UpsertStatus.error,
              errorMessage: err.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              createUpdateStatus: UpsertStatus.error,
              errorMessage: 'Error desconocido',
            ),
          );
        }
      },
    );
  }

  Future<void> updateArticle({
    required SalesCenterEntity salesCenterEntity,
    required String centroVenta,
    required String descripcion,
    required String correo,
  }) async {
    emit(state.copyWith(createUpdateStatus: UpsertStatus.loading));
    final result = await salesCenterRepository.updateSalesCenter(
      salesCenterEntity.copyWith(
        centroVenta: centroVenta,
        descripcion: descripcion,
        correo: correo,
      ),
    );

    result.when(
      ok: (ok) {
        emit(state.copyWith(createUpdateStatus: UpsertStatus.success));
      },
      err: (err) {
        emit(state.copyWith(createUpdateStatus: UpsertStatus.error));
      },
    );
  }
}
