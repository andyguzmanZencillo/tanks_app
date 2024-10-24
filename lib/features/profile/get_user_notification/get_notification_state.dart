part of 'get_notification_cubit.dart';

class GetUserNotificationState extends Equatable {
  const GetUserNotificationState({
    this.status = GeneralStatus.initial,
    this.errorMessage,
    this.list = const [],
  });

  final GeneralStatus status;
  final String? errorMessage;
  final List<UserNotificationEntity> list;

  GetUserNotificationState copyWith({
    GeneralStatus? status,
    String? errorMessage,
    List<UserNotificationEntity>? list,
  }) {
    return GetUserNotificationState(
      status: status ?? this.status,
      list: list ?? this.list,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, list];
}
