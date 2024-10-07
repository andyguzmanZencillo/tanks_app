part of 'upsert_config_cubit.dart';

class UpsertConfigState extends Equatable {
  const UpsertConfigState({
    this.upsertStatus = UpsertStatus.initial,
    this.errorMessage,
  });
  final UpsertStatus upsertStatus;

  final String? errorMessage;
  UpsertConfigState copyWith({
    UpsertStatus? upsertStatus,
    String? errorMessage,
  }) {
    return UpsertConfigState(
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
