part of 'user_device_cubit.dart';

enum OperationType { verification, register, getAll, delete, none }

class UserDeviceState extends Equatable {
  const UserDeviceState({
    this.status = GeneralStatus.initial,
    this.message,
    this.selected = const UserDeviceEntity.empty(),
    this.operationType = OperationType.none,
    this.list = const [],
  });
  final GeneralStatus status;
  final String? message;
  final OperationType operationType;

  final List<UserDeviceEntity> list;
  final UserDeviceEntity selected;

  UserDeviceState copyWith({
    GeneralStatus? status,
    String? message,
    OperationType? operationType,
    List<UserDeviceEntity>? list,
    UserDeviceEntity? selected,
  }) {
    return UserDeviceState(
      status: status ?? this.status,
      message: message ?? this.message,
      list: list ?? this.list,
      operationType: operationType ?? this.operationType,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object?> get props => [status, message, operationType, list, selected];
}
