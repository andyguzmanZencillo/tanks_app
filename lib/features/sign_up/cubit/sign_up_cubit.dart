import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/tank_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.userRepository) : super(const SignUpState());
  final UserRepository userRepository;
  Future<void> register({
    required String idCompany,
    required String user,
    required String password,
  }) async {
    final result = await userRepository.signUp(
      idCompany: int.parse(idCompany),
      user: user,
      password: password,
    );

    result.when(
      ok: (ok) {},
      err: (err) {},
    );
  }
}
