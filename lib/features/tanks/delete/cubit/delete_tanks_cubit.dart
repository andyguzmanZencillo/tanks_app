import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'delete_tanks_state.dart';

class DeleteTanksCubit extends Cubit<DeleteTanksState> {
  DeleteTanksCubit(this.tanksRepository) : super(const DeleteTanksState());

  final TanksRepository tanksRepository;

  Future<void> delete(int idArticle) async {
    emit(state.copyWith(deleteStatus: DeleteStatus.loading));
    final result = await tanksRepository.deleteTanks(idArticle);
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
