part of 'tanks_cubit.dart';

enum TanksStatus { loading, success, error, initial }

class TanksState extends Equatable {
  const TanksState({
    this.tanksStatus = TanksStatus.initial,
    this.list = const [],
    this.listCopy = const [],
    this.messageError,
    this.selected = const TanksEntity.empty(),
  });
  final TanksStatus tanksStatus;
  final List<TanksEntity> list;
  final List<TanksEntity> listCopy;

  final TanksEntity selected;
  final String? messageError;

  TanksState copyWith({
    TanksStatus? tanksStatus,
    List<TanksEntity>? list,
    List<TanksEntity>? listCopy,
    TanksEntity? selected,
    String? messageError,
  }) {
    return TanksState(
      tanksStatus: tanksStatus ?? this.tanksStatus,
      list: list ?? this.list,
      listCopy: listCopy ?? this.listCopy,
      selected: selected ?? this.selected,
      messageError: messageError ?? this.messageError,
    );
  }

  @override
  List<Object?> get props => [
        tanksStatus,
        list,
        listCopy,
        selected,
        messageError,
      ];
}
