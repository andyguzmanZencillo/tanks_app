part of 'upsert_tanks_cubit.dart';

class UpsertTanksState extends Equatable {
  const UpsertTanksState({
    this.upsertStatus = UpsertStatus.initial,
    this.prepareStatus = PrepareStatus.initial,
    this.errorMessage,
  });
  final UpsertStatus upsertStatus;
  final PrepareStatus prepareStatus;

  final String? errorMessage;

  UpsertTanksState copyWith({
    UpsertStatus? upsertStatus,
    PrepareStatus? prepareStatus,
    String? errorMessage,
  }) {
    return UpsertTanksState(
      upsertStatus: upsertStatus ?? this.upsertStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      prepareStatus: prepareStatus ?? this.prepareStatus,
    );
  }

  @override
  List<Object?> get props => [
        upsertStatus,
        errorMessage,
        prepareStatus,
      ];
}
