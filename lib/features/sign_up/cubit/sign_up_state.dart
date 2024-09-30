part of 'sign_up_cubit.dart';

enum SignUpStatus { loading, success, error, initial }

class SignUpState extends Equatable {
  const SignUpState({
    this.status = SignUpStatus.initial,
    this.errorMessage,
  });
  final SignUpStatus status;
  final String? errorMessage;

  SignUpState copyWith({
    SignUpStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
