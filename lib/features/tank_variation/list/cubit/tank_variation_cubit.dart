import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/tank_repository.dart';

part 'tank_variation_state.dart';

class TankVariationCubit extends Cubit<TankVariationState> {
  TankVariationCubit(this.consoleRepository)
      : super(const TankVariationState());

  final TankVariationRepository consoleRepository;

  void changeSelected(TankVariationEntity tankVariationEntity) {
    emit(state.copyWith(tankVariationSelected: tankVariationEntity));
  }

  Future<void> getToSaleCenter(int idSaleCenter, DateTime date) async {
    emit(state.copyWith(consoleStatus: TankVariationStatus.loading));
    final result = await consoleRepository.getToSaleCenter(
      idCentroVenta: idSaleCenter,
      date: date,
    );
    //await Future<dynamic>.delayed(const Duration(seconds: 3));
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            consoles: ok,
            consoleStatus: TankVariationStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            consoles: [],
            consoleStatus: TankVariationStatus.error,
          ),
        );
      },
    );
  }

  Future<void> getAll(int idSaleCenter, DateTime date) async {
    emit(state.copyWith(consoleStatus: TankVariationStatus.loading));
    final result = await consoleRepository.getToSaleCenter(
      idCentroVenta: idSaleCenter,
      date: date,
    );
    //await Future<dynamic>.delayed(const Duration(seconds: 3));
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            consoles: ok,
            consoleStatus: TankVariationStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            consoles: [],
            consoleStatus: TankVariationStatus.error,
          ),
        );
      },
    );
  }

  Future<void> getToSaleCenterDate(
    int idSaleCenter,
    DateTime dateInit,
    DateTime dateFinal,
  ) async {
    emit(state.copyWith(consoleStatus: TankVariationStatus.loading));
    final result = await consoleRepository.getToSaleCenterDate(
      idCentroVenta: idSaleCenter,
      dateInit: dateInit,
      dateFinal: dateFinal,
    );
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            consoles: ok,
            consoleStatus: TankVariationStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            consoles: [],
            consoleStatus: TankVariationStatus.error,
          ),
        );
      },
    );
  }

  Future<void> getToSaleCenterTankDate({
    required int idCentroVenta,
    required int idTanque,
    required DateTime dateInit,
    required DateTime dateFinal,
  }) async {
    emit(state.copyWith(consoleStatus: TankVariationStatus.loading));
    final result = await consoleRepository.getToSaleCenterTankDate(
      idCentroVenta: idCentroVenta,
      idTanque: idTanque,
      dateInit: dateInit,
      dateFinal: dateFinal,
    );
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            consoles: ok,
            consoleStatus: TankVariationStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            consoles: [],
            consoleStatus: TankVariationStatus.error,
          ),
        );
      },
    );
  }
}
