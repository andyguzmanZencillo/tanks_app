import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/tank_repository.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this.tankVariationRepository) : super(const DashboardState());
  final TankVariationRepository tankVariationRepository;

  void changeDates({
    required DateTime dateInit,
    required DateTime dateFinal,
  }) {
    emit(state.copyWith(dateInit: dateInit, dateFinal: dateFinal));
  }

  Future<void> getToSaleCenter() async {
    emit(state.copyWith(status: DashboardStatus.loading));
    final result = await tankVariationRepository.getAll();

    result.when(
      ok: (ok) {
        final sortedList = ok
          ..sort(
            (a, b) => b.fechaZ!.compareTo(a.fechaZ!),
          );
        emit(
          state.copyWith(
            list: sortedList,
            status: DashboardStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            list: [],
            status: DashboardStatus.error,
          ),
        );
      },
    );
  }
}
