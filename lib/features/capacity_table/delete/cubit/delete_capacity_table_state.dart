part of 'delete_capacity_table_cubit.dart';

class DeleteCapacityTableState extends Equatable {
  const DeleteCapacityTableState({
    this.deleteStatus = DeleteStatus.initial,
  });
  final DeleteStatus deleteStatus;

  DeleteCapacityTableState copyWith({
    DeleteStatus? deleteStatus,
  }) {
    return DeleteCapacityTableState(
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }

  @override
  List<Object> get props => [
        deleteStatus,
      ];
}
