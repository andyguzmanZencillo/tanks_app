import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'token_state.dart';

class TokenCubit extends Cubit<TokenState> {
  TokenCubit(this.tokenRepository) : super(const TokenState());
  final TokenRepository tokenRepository;

  Future<void> getToken({
    required String idCompany,
    required String user,
    required String password,
  }) async {
    emit(
      state.copyWith(
        status: GeneralStatus.loading,
        operation: OperationTokenCubit.getToken,
      ),
    );
    final result = await tokenRepository.getToken(
      idCompany: idCompany,
      user: user,
      password: password,
    );
    result.when(
      ok: (ok) {
        emit(state.copyWith(status: GeneralStatus.success));
      },
      err: (err) {
        if (err is InvalidDataFailure) {
          emit(
            state.copyWith(
              status: GeneralStatus.error,
              errorMessage: err.message,
            ),
          );
        } else {
          emit(state.copyWith(status: GeneralStatus.error));
        }
      },
    );
  }

  Future<void> generateToken() async {
    emit(
      state.copyWith(
        status: GeneralStatus.loading,
        operation: OperationTokenCubit.generate,
      ),
    );
    final result = await tokenRepository.generateToken();
    result.when(
      ok: (ok) {
        emit(state.copyWith(status: GeneralStatus.success));
      },
      err: (err) {
        if (err is InvalidDataFailure) {
          emit(
            state.copyWith(
              status: GeneralStatus.error,
              errorMessage: err.message,
            ),
          );
        } else {
          emit(state.copyWith(status: GeneralStatus.error));
        }
      },
    );
  }
}
