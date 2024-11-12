part of 'notification_cubit.dart';

class UserNotificationState extends Equatable {
  const UserNotificationState({
    this.status = GeneralStatus.initial,
    this.errorMessage,
    this.list = const [],
  });

  final GeneralStatus status;
  final String? errorMessage;
  final List<UserNotificationEntity> list;

  UserNotificationState copyWith({
    GeneralStatus? status,
    String? errorMessage,
    List<UserNotificationEntity>? list,
  }) {
    return UserNotificationState(
      status: status ?? this.status,
      list: list ?? this.list,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, list];
}
