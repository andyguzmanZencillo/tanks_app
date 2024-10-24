part of 'dashboard_cubit.dart';

enum DashboardStatus { initial, loading, success, error }

class DashboardState extends Equatable {
  const DashboardState({
    this.dateInit,
    this.dateFinal,
    this.status = DashboardStatus.initial,
    this.list = const [],
  });

  final DateTime? dateInit;
  final DateTime? dateFinal;
  final DashboardStatus status;
  final List<TankVariationEntity> list;

  DashboardState copyWith({
    DateTime? dateInit,
    DateTime? dateFinal,
    DashboardStatus? status,
    List<TankVariationEntity>? list,
  }) {
    return DashboardState(
      dateInit: dateInit ?? this.dateInit,
      dateFinal: dateFinal ?? this.dateFinal,
      status: status ?? this.status,
      list: list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [dateInit, dateFinal, status, list];
}
