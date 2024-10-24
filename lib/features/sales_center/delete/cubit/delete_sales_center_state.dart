part of 'delete_sales_center_cubit.dart';

class DeleteSalesCenterState extends Equatable {
  const DeleteSalesCenterState({
    this.deleteStatus = DeleteStatus.initial,
    this.errorMessage,
  });

  final DeleteStatus deleteStatus;
  final String? errorMessage;

  DeleteSalesCenterState copyWith({
    DeleteStatus? deleteStatus,
    String? errorMessage,
  }) {
    return DeleteSalesCenterState(
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
