import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/features/article/article.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'upsert_tanks_state.dart';

class UpsertTanksCubit extends Cubit<UpsertTanksState> {
  UpsertTanksCubit(this.tanksRepository, this.multiTableRepository)
      : super(const UpsertTanksState());
  final TanksRepository tanksRepository;
  final MultiTableRepository multiTableRepository;

  Future<void> create({
    required TanksEntity tanksEntity,
  }) async {
    emit(state.copyWith(upsertStatus: UpsertStatus.loading));
    final result = await tanksRepository.saveTanks(
      tanksEntity.copyWith(
        estado: state.statusCheck,
        modificable: state.modificable,
        manejaMm: state.manejaMm,
      ),
    );

    result.when(
      ok: (ok) {
        emit(state.copyWith(upsertStatus: UpsertStatus.success));
      },
      err: (err) {
        if (err is ResultFailure) {
          emit(
            state.copyWith(
              upsertStatus: UpsertStatus.error,
              errorMessage: err.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              upsertStatus: UpsertStatus.error,
              errorMessage: 'Error desconocido',
            ),
          );
        }
        emit(state.copyWith(upsertStatus: UpsertStatus.error));
      },
    );
  }

  Future<void> update({
    required TanksEntity tanksEntity,
  }) async {
    emit(state.copyWith(upsertStatus: UpsertStatus.loading));
    final result = await tanksRepository.updateTanks(
      tanksEntity.copyWith(
        estado: state.statusCheck,
        modificable: state.modificable,
        manejaMm: state.manejaMm,
      ),
    );

    result.when(
      ok: (ok) {
        emit(state.copyWith(upsertStatus: UpsertStatus.success));
      },
      err: (err) {
        emit(state.copyWith(upsertStatus: UpsertStatus.error));
      },
    );
  }

  Future<void> prepareData() async {
    emit(state.copyWith(prepareStatus: PrepareStatus.loading));
    final result = await multiTableRepository.getAll();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            prepareStatus: PrepareStatus.success,
            articles: ok.articles,
            consoles: ok.consoles,
            salesCenters: ok.salesCenter,
          ),
        );
      },
      err: (err) {
        if (err is ResultFailure) {
          emit(
            state.copyWith(
              prepareStatus: PrepareStatus.error,
              errorMessage: err.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              prepareStatus: PrepareStatus.error,
            ),
          );
        }
      },
    );
  }

  void changeStatusCheck({required bool check}) {
    emit(state.copyWith(statusCheck: check));
  }

  void changeModificableCheck({required bool check}) {
    emit(state.copyWith(modificable: check));
  }

  void changeManejaMmCheck({required bool check}) {
    emit(state.copyWith(manejaMm: check));
  }

  void changeChecks({
    required bool statusCheck,
    required bool modificable,
    required bool manejaMm,
  }) {
    emit(
      state.copyWith(
        statusCheck: statusCheck,
        modificable: modificable,
        manejaMm: manejaMm,
      ),
    );
  }
}
