part of 'perfil_cubit.dart';

class PerfilState extends Equatable {
  const PerfilState({
    this.status = GeneralStatus.initial,
    this.errorMessage,
    this.user = const UserEntity.empty(),
  });
  final GeneralStatus status;
  final String? errorMessage;
  final UserEntity user;

  PerfilState copyWith({
    GeneralStatus? status,
    String? errorMessage,
    UserEntity? user,
  }) {
    return PerfilState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, user];
}
