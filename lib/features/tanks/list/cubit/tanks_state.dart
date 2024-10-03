part of 'tanks_cubit.dart';

enum TanksStatus { loading, success, error, initial }

class TanksState extends Equatable {
  const TanksState({
    this.tanksStatus = TanksStatus.initial,
    this.tanks = const [],
  });
  final TanksStatus tanksStatus;
  final List<TanksEntity> tanks;

  TanksState copyWith({
    TanksStatus? tanksStatus,
    List<TanksEntity>? tanks,
  }) {
    return TanksState(
      tanksStatus: tanksStatus ?? this.tanksStatus,
      tanks: tanks ?? this.tanks,
    );
  }

  @override
  List<Object> get props => [tanksStatus, tanks];
}
