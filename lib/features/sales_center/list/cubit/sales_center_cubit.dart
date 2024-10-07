import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';
import 'package:tank_repository/features/sales_center/repository/sales_center_repository.dart';

part 'sales_center_state.dart';

class SalesCenterCubit extends Cubit<SalesCenterState> {
  SalesCenterCubit(this.salesCenterRepository)
      : super(const SalesCenterState());

  final SalesCenterRepository salesCenterRepository;

  Future<bool> getAll() async {
    emit(state.copyWith(salesCenterStatus: SalesCenterStatus.loading));
    final result = await salesCenterRepository.getAll();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            salesCenters: ok,
            salesCenterStatus: SalesCenterStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            salesCenters: [],
            salesCenterStatus: SalesCenterStatus.error,
          ),
        );

        if (err is ResultFailure) {
          emit(
            state.copyWith(
              salesCenters: [],
              salesCenterStatus: SalesCenterStatus.error,
              messageError: err.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              salesCenters: [],
              salesCenterStatus: SalesCenterStatus.error,
              messageError: 'Error desconocido',
            ),
          );
        }
      },
    );
    return result.isOk();
  }
}
