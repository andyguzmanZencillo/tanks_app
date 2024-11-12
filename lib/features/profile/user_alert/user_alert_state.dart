part of 'user_alert_cubit.dart';

class UserAlertState extends Equatable {
  const UserAlertState({
    this.status = GeneralStatus.initial,
    this.errorMessage,
    this.list = const [],
  });
  final GeneralStatus status;
  final String? errorMessage;
  final List<UserAlertEntity> list;

  UserAlertState copyWith({
    GeneralStatus? status,
    String? errorMessage,
    List<UserAlertEntity>? list,
  }) {
    return UserAlertState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      list: list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, list];
}
