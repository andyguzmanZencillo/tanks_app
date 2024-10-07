import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/features/sales_center/delete/cubit/delete_sales_center_cubit.dart';

part 'delete_config_state.dart';

class DeleteConfigCubit extends Cubit<DeleteConfigState> {
  DeleteConfigCubit(this.configRepository) : super(const DeleteConfigState());

  final ConfigRepository configRepository;

  Future<void> delete(int idConfig) async {
    emit(state.copyWith(deleteStatus: DeleteStatus.loading));
    final result = await configRepository.deleteConfig(idConfig);
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
