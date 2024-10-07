part of 'delete_config_cubit.dart';

class DeleteConfigState extends Equatable {
  const DeleteConfigState({
    this.deleteStatus = DeleteStatus.initial,
  });
  final DeleteStatus deleteStatus;

  DeleteConfigState copyWith({
    DeleteStatus? deleteStatus,
  }) {
    return DeleteConfigState(
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }

  @override
  List<Object> get props => [
        deleteStatus,
      ];
}
