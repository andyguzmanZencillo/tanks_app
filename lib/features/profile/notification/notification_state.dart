part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.status = GeneralStatus.initial,
    this.errorMessage,
    this.selected = const NotificationEntity.empty(),
    this.list = const [],
    this.listSelected = const [],
  });
  final GeneralStatus status;
  final String? errorMessage;
  final List<NotificationEntity> list;
  final List<NotificationEntity> listSelected;
  final NotificationEntity selected;

  NotificationState copyWith({
    GeneralStatus? status,
    String? errorMessage,
    List<NotificationEntity>? list,
    List<NotificationEntity>? listSelected,
    NotificationEntity? selected,
  }) {
    return NotificationState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      list: list ?? this.list,
      selected: selected ?? this.selected,
      listSelected: listSelected ?? this.listSelected,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        list,
        selected,
        listSelected,
      ];
}
