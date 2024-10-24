part of 'get_alert_cubit.dart';

class GetAlertState extends Equatable {
  const GetAlertState({
    this.status = GeneralStatus.initial,
    this.errorMessage,
    this.list = const [],
    this.listSelected = const [],
    this.selected = const AlertEntity.empty(),
  });
  final GeneralStatus status;
  final String? errorMessage;
  final List<AlertEntity> list;
  final List<AlertEntity> listSelected;
  final AlertEntity selected;

  GetAlertState copyWith({
    GeneralStatus? status,
    String? errorMessage,
    List<AlertEntity>? list,
    AlertEntity? selected,
    List<AlertEntity>? listSelected,
  }) {
    return GetAlertState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      list: list ?? this.list,
      listSelected: listSelected ?? this.listSelected,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        list,
        selected,
        listSelected,
      ];
}
