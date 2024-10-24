import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'perfil_state.dart';

class PerfilCubit extends Cubit<PerfilState> {
  PerfilCubit(this.userRepository) : super(const PerfilState());
  final UserRepository userRepository;

  Future<void> getInfo() async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await userRepository.getUser();
    result.when(
      ok: (ok) {
        emit(state.copyWith(user: ok, status: GeneralStatus.success));
      },
      err: (err) {
        if (err is ResultFailure) {
          emit(
            state.copyWith(
              errorMessage: err.message,
              status: GeneralStatus.error,
            ),
          );
        } else {
          emit(state.copyWith(status: GeneralStatus.error));
        }
      },
    );
  }
}
