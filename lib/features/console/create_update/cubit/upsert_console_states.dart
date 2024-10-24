part of 'upsert_console_cubit.dart';

class UpsertConsoleState extends Equatable {
  const UpsertConsoleState({
    this.upsertStatus = UpsertStatus.initial,
    this.errorMessage,
  });

  final UpsertStatus upsertStatus;
  final String? errorMessage;

  UpsertConsoleState copyWith({
    UpsertStatus? upsertStatus,
    String? errorMessage,
  }) {
    return UpsertConsoleState(
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
