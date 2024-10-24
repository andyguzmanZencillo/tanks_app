part of 'delete_console_cubit.dart';

class DeleteConsoleState extends Equatable {
  const DeleteConsoleState({
    this.deleteStatus = DeleteStatus.initial,
    this.errorMessage,
  });

  final DeleteStatus deleteStatus;
  final String? errorMessage;

  DeleteConsoleState copyWith({
    DeleteStatus? deleteStatus,
    String? errorMessage,
  }) {
    return DeleteConsoleState(
      deleteStatus: deleteStatus ?? this.deleteStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        deleteStatus,
        errorMessage,
      ];
}
