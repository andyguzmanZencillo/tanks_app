part of 'upsert_sales_center_cubit.dart';

class UpsertSalesCenterState extends Equatable {
  const UpsertSalesCenterState({
    this.createUpdateStatus = UpsertStatus.initial,
    this.errorMessage, // Añadido el campo errorMessage
  });

  final UpsertStatus createUpdateStatus;
  final String? errorMessage; // Campo para almacenar el mensaje de error

  UpsertSalesCenterState copyWith({
    UpsertStatus? createUpdateStatus,
    String? errorMessage, // Añadido al método copyWith
  }) {
    return UpsertSalesCenterState(
      createUpdateStatus: createUpdateStatus ?? this.createUpdateStatus,
      errorMessage: errorMessage ?? this.errorMessage, // Actualiza errorMessage
    );
  }

  @override
  List<Object?> get props => [
        createUpdateStatus,
        errorMessage, // Añadido a la lista de propiedades
      ];
}
