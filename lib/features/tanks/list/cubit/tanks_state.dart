part of 'tanks_cubit.dart';

enum TanksStatus { loading, success, error, initial }

class TanksState extends Equatable {
  const TanksState({
    this.tanksStatus = TanksStatus.initial,
    this.tanks = const [],
    this.messageError,
    this.tankSelected = const TanksEntity.empty(),
  });
  final TanksStatus tanksStatus;
  final List<TanksEntity> tanks;
  final TanksEntity tankSelected;
  final String? messageError;

  TanksState copyWith({
    TanksStatus? tanksStatus,
    List<TanksEntity>? tanks,
    TanksEntity? tankSelected,
    String? messageError,
  }) {
    return TanksState(
      tanksStatus: tanksStatus ?? this.tanksStatus,
      tanks: tanks ?? this.tanks,
      tankSelected: tankSelected ?? this.tankSelected,
      messageError: messageError ?? this.messageError,
    );
  }

  @override
  List<Object?> get props => [
        tanksStatus,
        tanks,
        tankSelected,
        messageError,
      ];
}
