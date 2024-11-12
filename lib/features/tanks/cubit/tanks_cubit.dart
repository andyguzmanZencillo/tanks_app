import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/helpers/dialog_info.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/features/tanks/helpers/message_tanks_listener.dart';

part 'tanks_state.dart';

class TanksCubit extends Cubit<TanksState> {
  TanksCubit(this.tanksRepository) : super(const TanksState());

  final TanksRepository tanksRepository;

  void changeSelected(TanksEntity tanksEntity) {
    emit(state.copyWith(selected: tanksEntity));
  }

  Future<void> getAll() async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageTanksListener.loadingGet,
      ),
    );
    final result = await tanksRepository.getAll();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            list: ok,
            listCopy: ok,
            selected: ok.firstOrNull,
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageTanksListener.successGet,
          ),
        );
      },
      err: (err) {
        if (err is InvalidDataFailure) {
          emit(
            state.copyWith(
              generalStatus: GeneralStatus.error,
              list: [],
              listCopy: [],
              dialogMessage: DialogMessage(message: err.message),
            ),
          );
        } else {
          emit(
            state.copyWith(
              list: [],
              listCopy: [],
              generalStatus: GeneralStatus.error,
              dialogMessage: MessageTanksListener.error,
            ),
          );
        }
      },
    );
  }

  Future<bool> getToSaleCenter(int idSaleCenter) async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageTanksListener.loadingGet,
      ),
    );
    final result = await tanksRepository.getToSaleCenter(idSaleCenter);
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            list: ok,
            listCopy: ok,
            selected: ok.firstOrNull,
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageTanksListener.successGet,
          ),
        );
      },
      err: (err) {
        if (err is InvalidDataFailure) {
          emit(
            state.copyWith(
              generalStatus: GeneralStatus.error,
              list: [],
              listCopy: [],
              dialogMessage: DialogMessage(message: err.message),
            ),
          );
        } else {
          emit(
            state.copyWith(
              list: [],
              listCopy: [],
              generalStatus: GeneralStatus.error,
              dialogMessage: MessageTanksListener.error,
            ),
          );
        }
      },
    );
    return result.isOk();
  }

  void search(String text) {
    final listCopy = [...state.listCopy];
    final listSearh = listCopy
        .where(
          (element) =>
              element.descripcion.toLowerCase().contains(text.toLowerCase()),
        )
        .toList();

    emit(state.copyWith(list: listSearh));
  }

  Future<void> delete(int idArticle) async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageTanksListener.loadingDelete,
      ),
    );
    final result = await tanksRepository.deleteTanks(idArticle);
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageTanksListener.successDelete,
          ),
        );
      },
      err: (err) {
        if (err is InvalidDataFailure) {
          emit(
            state.copyWith(
              generalStatus: GeneralStatus.error,
              dialogMessage: DialogMessage(message: err.message),
            ),
          );
        } else {
          emit(
            state.copyWith(
              generalStatus: GeneralStatus.error,
              dialogMessage: MessageTanksListener.error,
            ),
          );
        }
      },
    );
  }
}
