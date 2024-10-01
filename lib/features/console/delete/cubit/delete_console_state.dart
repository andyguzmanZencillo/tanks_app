part of 'delete_console_cubit.dart';

class DeleteConsoleState extends Equatable {
  const DeleteConsoleState({
    this.deleteStatus = DeleteStatus.initial,
  });
  final DeleteStatus deleteStatus;

  DeleteConsoleState copyWith({
    DeleteStatus? deleteStatus,
  }) {
    return DeleteConsoleState(
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }

  @override
  List<Object> get props => [
        deleteStatus,
      ];
}
