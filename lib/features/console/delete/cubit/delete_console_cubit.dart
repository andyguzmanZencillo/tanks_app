import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'delete_console_state.dart';

class DeleteConsoleCubit extends Cubit<DeleteConsoleState> {
  DeleteConsoleCubit(this.salesCenterRepository)
      : super(const DeleteConsoleState());

  final ConsoleRepository salesCenterRepository;

  Future<void> delete(int idArticle) async {
    emit(state.copyWith(deleteStatus: DeleteStatus.loading));
    final result = await salesCenterRepository.deleteConsole(idArticle);
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
