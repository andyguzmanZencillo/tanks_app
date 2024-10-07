part of 'upsert_tank_variation_cubit.dart';

class UpsertTankVariationState extends Equatable {
  const UpsertTankVariationState({
    this.upsertStatus = UpsertStatus.initial,
    this.errorMessage,
  });
  final UpsertStatus upsertStatus;

  final String? errorMessage;
  UpsertTankVariationState copyWith({
    UpsertStatus? upsertStatus,
    String? errorMessage,
  }) {
    return UpsertTankVariationState(
      upsertStatus: upsertStatus ?? this.upsertStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        upsertStatus,
        errorMessage,
      ];
}
