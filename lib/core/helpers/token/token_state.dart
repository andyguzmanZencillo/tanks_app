part of 'token_cubit.dart';

enum OperationTokenCubit { generate, getToken, none }

class TokenState extends Equatable {
  const TokenState({
    this.status = GeneralStatus.initial,
    this.errorMessage,
    this.operation = OperationTokenCubit.none,
  });
  final GeneralStatus status;
  final OperationTokenCubit operation;
  final String? errorMessage;

  TokenState copyWith({
    GeneralStatus? status,
    String? errorMessage,
    OperationTokenCubit? operation,
  }) {
    return TokenState(
      status: status ?? this.status,
      operation: operation ?? this.operation,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
