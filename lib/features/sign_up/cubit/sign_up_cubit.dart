import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.userRepository) : super(const SignUpState());
  final UserRepository userRepository;
  Future<void> register({
    required String idCompany,
    required String user,
    required String password,
    required String name,
  }) async {
    emit(state.copyWith(status: SignUpStatus.loading));
    final result = await userRepository.signUp(
      idCompany: int.parse(idCompany),
      user: user,
      name: name,
      password: password,
    );

    result.when(
      ok: (ok) {
        emit(state.copyWith(status: SignUpStatus.success));
      },
      err: (err) {
        if (err is ResultFailure) {
          emit(
            state.copyWith(
              status: SignUpStatus.error,
              errorMessage: err.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: SignUpStatus.error,
              errorMessage: 'Error desconocido',
            ),
          );
        }
      },
    );
  }
}
