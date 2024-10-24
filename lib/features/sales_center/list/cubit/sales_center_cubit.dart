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

  void changeSelected(SalesCenterEntity selected) {
    emit(state.copyWith(selected: selected));
  }

  Future<bool> getAll() async {
    emit(state.copyWith(salesCenterStatus: SalesCenterStatus.loading));
    final result = await salesCenterRepository.getAll();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            list: ok,
            listCopy: ok,
            salesCenterStatus: SalesCenterStatus.success,
          ),
        );
      },
      err: (err) {
        if (err is ResultFailure) {
          emit(
            state.copyWith(
              list: [],
              listCopy: [],
              salesCenterStatus: SalesCenterStatus.error,
              errorMessage: err.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              list: [],
              listCopy: [],
              salesCenterStatus: SalesCenterStatus.error,
              errorMessage: 'Error desconocido',
            ),
          );
        }
      },
    );
    return result.isOk();
  }

  void search(String text) {
    final listCopy = [...state.listCopy];
    final listSearh = listCopy
        .where(
          (element) =>
              element.centroVenta.toLowerCase().contains(text.toLowerCase()),
        )
        .toList();

    emit(state.copyWith(list: listSearh));
  }
}
