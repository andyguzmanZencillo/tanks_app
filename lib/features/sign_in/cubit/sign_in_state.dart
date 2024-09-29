part of 'sign_in_cubit.dart';

enum SignStatus { loading, success, error, initial }

class SignInState extends Equatable {
  const SignInState({
    this.status = SignStatus.initial,
    this.errorMessage,
  });
  final SignStatus status;
  final String? errorMessage;

  SignInState copyWith({
    SignStatus? status,
    String? errorMessage,
  }) {
    return SignInState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
