part of 'user_device_cubit.dart';

enum OperationType { verification, register, none }

class UserDeviceState extends Equatable {
  const UserDeviceState({
    this.status = GeneralStatus.initial,
    this.message = '',
    this.operationType = OperationType.none,
  });
  final GeneralStatus status;
  final String message;
  final OperationType operationType;

  UserDeviceState copyWith({
    GeneralStatus? status,
    String? message,
    OperationType? operationType,
  }) {
    return UserDeviceState(
      status: status ?? this.status,
      message: message ?? this.message,
      operationType: operationType ?? this.operationType,
    );
  }

  @override
  List<Object> get props => [status, message, operationType];
}
