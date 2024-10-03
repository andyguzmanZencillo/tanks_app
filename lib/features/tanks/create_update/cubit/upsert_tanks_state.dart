part of 'upsert_tanks_cubit.dart';

class UpsertTanksState extends Equatable {
  const UpsertTanksState({
    this.upsertStatus = UpsertStatus.initial,
    this.errorMessage,
  });
  final UpsertStatus upsertStatus;
  final String? errorMessage;

  UpsertTanksState copyWith({
    UpsertStatus? upsertStatus,
    String? errorMessage,
  }) {
    return UpsertTanksState(
      upsertStatus: upsertStatus ?? this.upsertStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [upsertStatus, errorMessage];
}
