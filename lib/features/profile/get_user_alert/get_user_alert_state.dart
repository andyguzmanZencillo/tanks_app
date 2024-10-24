part of 'get_user_alert_cubit.dart';

class GetUserAlertState extends Equatable {
  const GetUserAlertState({
    this.status = GeneralStatus.initial,
    this.errorMessage,
    this.list = const [],
  });
  final GeneralStatus status;
  final String? errorMessage;
  final List<UserAlertEntity> list;

  GetUserAlertState copyWith({
    GeneralStatus? status,
    String? errorMessage,
    List<UserAlertEntity>? list,
  }) {
    return GetUserAlertState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      list: list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, list];
}
