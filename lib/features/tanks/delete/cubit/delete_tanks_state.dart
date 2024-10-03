part of 'delete_tanks_cubit.dart';

class DeleteTanksState extends Equatable {
  const DeleteTanksState({
    this.deleteStatus = DeleteStatus.initial,
  });
  final DeleteStatus deleteStatus;

  DeleteTanksState copyWith({
    DeleteStatus? deleteStatus,
  }) {
    return DeleteTanksState(
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }

  @override
  List<Object> get props => [
        deleteStatus,
      ];
}
