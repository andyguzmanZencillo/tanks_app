part of 'upsert_console_cubit.dart';

class UpsertConsoleState extends Equatable {
  const UpsertConsoleState({
    this.upsertStatus = UpsertStatus.initial,
  });
  final UpsertStatus upsertStatus;

  UpsertConsoleState copyWith({
    UpsertStatus? upsertStatus,
  }) {
    return UpsertConsoleState(
      upsertStatus: upsertStatus ?? this.upsertStatus,
    );
  }

  @override
  List<Object> get props => [
        upsertStatus,
      ];
}
