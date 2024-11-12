import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/helpers/dialog_info.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/features/sign_in/helper/message_sign_in_listener.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.userRepository) : super(const SignInState());

  final UserRepository userRepository;

  Future<void> login({
    required String idCompany,
    required String userName,
    required String password,
  }) async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: SignInMessages.loading,
      ),
    );
    final result = await userRepository.signIn(
      idCompany: int.parse(idCompany),
      user: userName,
      password: password,
    );
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            generalStatus: GeneralStatus.success,
            dialogMessage: SignInMessages.success,
          ),
        );
      },
      err: (err) {
        if (err is InvalidDataFailure) {
          emit(
            state.copyWith(
              generalStatus: GeneralStatus.error,
              dialogMessage: DialogMessage(message: err.message),
            ),
          );
        } else {
          emit(
            state.copyWith(
              generalStatus: GeneralStatus.error,
              dialogMessage: SignInMessages.error,
            ),
          );
        }
      },
    );
  }
}
