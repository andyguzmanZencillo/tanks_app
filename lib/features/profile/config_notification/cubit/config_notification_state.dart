part of 'config_notification_cubit.dart';

class ConfigNotificationState extends Equatable {
  const ConfigNotificationState({
    this.status = GeneralStatus.initial,
    this.errorMessage,
  });
  final GeneralStatus status;
  final String? errorMessage;

  ConfigNotificationState copyWith({
    GeneralStatus? status,
    String? errorMessage,
  }) {
    return ConfigNotificationState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
