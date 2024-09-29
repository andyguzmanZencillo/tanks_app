import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/tank_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.userRepository) : super(const SignInState());

  final UserRepository userRepository;

  Future<void> login({
    required String idCompany,
    required String userName,
    required String password,
  }) async {
    emit(state.copyWith(status: SignStatus.loading));
    final result = await userRepository.signIn(
      idCompany: int.parse(idCompany),
      user: userName,
      password: password,
    );

    result.when(
      ok: (ok) {
        emit(state.copyWith(status: SignStatus.success));
      },
      err: (err) {
        emit(state.copyWith(status: SignStatus.error));
      },
    );
  }
}
