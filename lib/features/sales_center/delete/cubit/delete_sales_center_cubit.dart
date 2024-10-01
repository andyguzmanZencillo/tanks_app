import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/features/sales_center/repository/sales_center_repository.dart';

part 'delete_sales_center_state.dart';

class DeleteSalesCenterCubit extends Cubit<DeleteSalesCenterState> {
  DeleteSalesCenterCubit(this.salesCenterRepository)
      : super(const DeleteSalesCenterState());

  final SalesCenterRepository salesCenterRepository;

  Future<void> delete(int idArticle) async {
    emit(state.copyWith(deleteStatus: DeleteStatus.loading));
    final result = await salesCenterRepository.deleteSalesCenter(idArticle);
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            deleteStatus: DeleteStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            deleteStatus: DeleteStatus.error,
          ),
        );
      },
    );
  }

  Future<void> udpateStatus(DeleteStatus deleteStatus) async {
    emit(state.copyWith(deleteStatus: deleteStatus));
  }
}
