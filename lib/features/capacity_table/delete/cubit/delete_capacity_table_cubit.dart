import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/features/sales_center/delete/cubit/delete_sales_center_cubit.dart';

part 'delete_capacity_table_state.dart';

class DeleteCapacityTableCubit extends Cubit<DeleteCapacityTableState> {
  DeleteCapacityTableCubit(this.tanksRepository)
      : super(const DeleteCapacityTableState());

  final CapacityTableRepository tanksRepository;

  Future<void> delete(int idArticle) async {
    emit(state.copyWith(deleteStatus: DeleteStatus.loading));
    final result = await tanksRepository.deleteCapacityTable(idArticle);
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
