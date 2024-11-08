import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/features/tank_variation/entity/tank_variation_multi_entity.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'tank_variation_state.dart';

class TankVariationCubit extends Cubit<TankVariationState> {
  TankVariationCubit(this.consoleRepository)
      : super(const TankVariationState());

  final TankVariationRepository consoleRepository;

  void changeSelected(TankVariationEntity selected) {
    emit(state.copyWith(selected: selected));
  }

  void changeSelectedPro(TankVariationMultiEntity selected) {
    emit(state.copyWith(selectedPro: selected));
  }

  void changeDateSearch(DateTime dateSearch) {
    emit(state.copyWith(dateSearch: dateSearch));
  }

  Future<void> getBySaleCenterAndDate(int idSaleCenter, DateTime date) async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await consoleRepository.getBySaleCenterAndDate(
      idCentroVenta: idSaleCenter,
      date: date,
    );
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            list: ok,
            status: GeneralStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            list: [],
            status: GeneralStatus.error,
          ),
        );
      },
    );
  }

  Future<void> getBySaleCenterAndDatePro(
    int idSaleCenter,
    DateTime date,
  ) async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await consoleRepository.getBySaleCenterAndDatePro(
      idCentroVenta: idSaleCenter,
      date: date,
    );
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            listPro: ok,
            status: GeneralStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            listPro: [],
            status: GeneralStatus.error,
          ),
        );
      },
    );
  }

  void clearList() {
    emit(state.copyWith(listPro: []));
  }

  Future<void> getBySaleCenterAndRangeDate(
    int idSaleCenter,
    DateTime dateInit,
    DateTime dateFinal,
  ) async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await consoleRepository.getBySaleCenterAndRangeDate(
      idCentroVenta: idSaleCenter,
      dateInit: dateInit,
      dateFinal: dateFinal,
    );
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            list: ok,
            status: GeneralStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            list: [],
            status: GeneralStatus.error,
          ),
        );
      },
    );
  }

  Future<void> getBySaleCenterAndTankAndDate({
    required int idCentroVenta,
    required int idTanque,
    required DateTime dateInit,
    required DateTime dateFinal,
  }) async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await consoleRepository.getBySaleCenterAndTankAndDate(
      idCentroVenta: idCentroVenta,
      idTanque: idTanque,
      dateInit: dateInit,
      dateFinal: dateFinal,
    );
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            list: ok,
            status: GeneralStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            list: [],
            status: GeneralStatus.error,
          ),
        );
      },
    );
  }

  Future<void> getByTank({
    required int idCentroVenta,
    required int idTanque,
    required DateTime dateInit,
    required DateTime dateFinal,
  }) async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await consoleRepository.getByTank(
      idTanque: idTanque,
    );
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            list: ok,
            status: GeneralStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            list: [],
            status: GeneralStatus.error,
          ),
        );
      },
    );
  }
}
