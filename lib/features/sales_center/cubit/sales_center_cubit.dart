import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';
import 'package:tank_repository/features/sales_center/repository/sales_center_repository.dart';
import 'package:tanks_app/core/helpers/dialog_info.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/features/sales_center/helpers/message_sales_center_listener.dart';

part 'sales_center_state.dart';

class SalesCenterCubit extends Cubit<SalesCenterState> {
  SalesCenterCubit(this.salesCenterRepository)
      : super(const SalesCenterState());

  final SalesCenterRepository salesCenterRepository;

  void changeSelected(SalesCenterEntity selected) {
    emit(state.copyWith(selected: selected));
  }

  Future<bool> getAll() async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageSalesCenterListener.loadingGet,
      ),
    );
    final result = await salesCenterRepository.getAll();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            list: ok,
            listCopy: ok,
            selected: ok.firstOrNull,
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageSalesCenterListener.successGet,
          ),
        );
      },
      err: (err) {
        if (err is InvalidDataFailure) {
          emit(
            state.copyWith(
              list: [],
              listCopy: [],
              generalStatus: GeneralStatus.error,
              dialogMessage: DialogMessage(message: err.message),
            ),
          );
        } else {
          emit(
            state.copyWith(
              list: [],
              listCopy: [],
              generalStatus: GeneralStatus.error,
              dialogMessage: MessageSalesCenterListener.error,
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
              element.centroVenta.toLowerCase().contains(text.toLowerCase()),
        )
        .toList();

    emit(state.copyWith(list: listSearh));
  }

  Future<void> create({
    required String centroVenta,
    required String descripcion,
    required String correo,
  }) async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageSalesCenterListener.loadingCreate,
      ),
    );
    final result = await salesCenterRepository.saveSalesCenter(
      SalesCenterEntity(
        idCentroVenta: 0,
        idCompania: 0,
        centroVenta: centroVenta,
        descripcion: descripcion,
        correo: correo,
      ),
    );

    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageSalesCenterListener.successCreate,
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
              dialogMessage: MessageSalesCenterListener.error,
            ),
          );
        }
      },
    );
  }

  Future<void> updateArticle({
    required SalesCenterEntity salesCenterEntity,
    required String centroVenta,
    required String descripcion,
    required String correo,
  }) async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageSalesCenterListener.loadingUpdate,
      ),
    );
    final result = await salesCenterRepository.updateSalesCenter(
      salesCenterEntity.copyWith(
        centroVenta: centroVenta,
        descripcion: descripcion,
        correo: correo,
      ),
    );

    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageSalesCenterListener.successUpdate,
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
              dialogMessage: MessageSalesCenterListener.error,
            ),
          );
        }
      },
    );
  }

  Future<void> delete(int idArticle) async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageSalesCenterListener.loadingDelete,
      ),
    );
    final result = await salesCenterRepository.deleteSalesCenter(idArticle);
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageSalesCenterListener.successDelete,
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
              dialogMessage: MessageSalesCenterListener.error,
            ),
          );
        }
      },
    );
  }
}
