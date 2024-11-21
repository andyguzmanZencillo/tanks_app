import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/features/article/entity/article_entity.dart';
import 'package:tank_repository/features/console/entity/console_entity.dart';
import 'package:tank_repository/features/multi_table/repository/multi_table_repositoy.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';
import 'package:tank_repository/features/tanks/repository/tanks_repository.dart';
import 'package:tanks_app/core/helpers/dialog_info.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/features/tanks/helpers/message_tanks_listener.dart';

part 'prepare_tank_state.dart';

class PrepareTankCubit extends Cubit<PrepareTankState> {
  PrepareTankCubit(this.tanksRepository, this.multiTableRepository)
      : super(const PrepareTankState());

  final TanksRepository tanksRepository;
  final MultiTableRepository multiTableRepository;
  Future<void> prepareData() async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageTanksListener.loadingPrepare,
      ),
    );
    final result = await multiTableRepository.getAll();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageTanksListener.successPrepare,
            articles: ok.articles,
            consoles: ok.consoles,
            salesCenters: ok.salesCenter,
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

  void selectArticle(ArticleEntity article) {
    emit(state.copyWith(selectedArticle: article));
  }

  void selectConsole(ConsoleEntity console) {
    emit(state.copyWith(selectedConsole: console));
  }

  void selectSalesCenter(SalesCenterEntity salesCenter) {
    emit(state.copyWith(selectedSalesCenter: salesCenter));
  }

  void changeSelected(
    ArticleEntity? article,
    ConsoleEntity? console,
    SalesCenterEntity? salesCenterEntity,
  ) {
    emit(
      state.copyWith(
        selectedArticle: article,
        selectedConsole: console,
        selectedSalesCenter: salesCenterEntity,
      ),
    );
  }
}
