part of 'notify_dialog_handler_cubit.dart';

enum NotificationType { success, error, info, none }

class NotifyDialogHandlerState extends Equatable {
  const NotifyDialogHandlerState({
    this.notification = const NotificationInfo.empty(),
  });
  final NotificationInfo notification;

  NotifyDialogHandlerState copyWith(NotificationInfo notification) {
    return NotifyDialogHandlerState(
      notification: notification,
    );
  }

  @override
  List<Object> get props => [notification];
}

class NotificationInfo extends Equatable {
  const NotificationInfo(
    this.notificationType, {
    required this.message,
    this.title,
  });

  const NotificationInfo.empty()
      : notificationType = NotificationType.none,
        title = '',
        message = '';

  final NotificationType notificationType;
  final String? title;
  final String message;

  @override
  List<Object?> get props => [
        notificationType,
        title,
        message,
      ];
}
