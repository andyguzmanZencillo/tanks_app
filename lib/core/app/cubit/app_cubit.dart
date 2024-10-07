import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/tank_repository.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this.userRepository) : super(const AppState());
  final UserRepository userRepository;
  Future<void> verificationLogin() async {
    final result = await userRepository.verification();
    result.when(
      ok: (ok) {
        emit(state.copyWith(status: AppStatus.loged));
      },
      err: (failure) {
        emit(state.copyWith(status: AppStatus.noLoged));
      },
    );
  }
}
