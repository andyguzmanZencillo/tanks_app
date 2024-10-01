part of 'delete_sales_center_cubit.dart';

enum DeleteStatus { loading, success, error, initial }

class DeleteSalesCenterState extends Equatable {
  const DeleteSalesCenterState({
    this.deleteStatus = DeleteStatus.initial,
  });
  final DeleteStatus deleteStatus;

  DeleteSalesCenterState copyWith({
    DeleteStatus? deleteStatus,
  }) {
    return DeleteSalesCenterState(
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }

  @override
  List<Object> get props => [
        deleteStatus,
      ];
}
