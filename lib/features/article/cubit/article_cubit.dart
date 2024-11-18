import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/features/article/entity/article_entity.dart';
import 'package:tank_repository/features/article/repository/article_repository.dart';
import 'package:tanks_app/core/helpers/dialog_info.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/features/article/helpers/message_article_listener.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit(this.articleRepository) : super(const ArticleState());

  final ArticleRepository articleRepository;

  void onChangeSelected(ArticleEntity selected) {
    emit(state.copyWith(selected: selected));
  }

  Future<bool> getArticles() async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageArticleListener.loadingGet,
      ),
    );
    final result = await articleRepository.getArticles();
    result.when(
      ok: (ok) {
        ok.sort((a, b) => b.articulo.compareTo(a.articulo));
        emit(
          state.copyWith(
            list: ok,
            listCopy: ok,
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageArticleListener.successGet,
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
              dialogMessage: MessageArticleListener.error,
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
              element.articulo.toLowerCase().contains(text.toLowerCase()),
        )
        .toList();

    emit(state.copyWith(list: listSearh));
  }

  Future<void> createArticle({
    required String name,
    required String description,
    required String code,
    required String color,
    required String price,
  }) async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageArticleListener.loadingCreate,
      ),
    );
    final result = await articleRepository.saveArticle(
      ArticleEntity(
        idArticulo: 0,
        articulo: name,
        descripcion: description,
        color: color,
        precio: double.parse(price),
        code: code,
      ),
    );

    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageArticleListener.successCreate,
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
              dialogMessage: MessageArticleListener.error,
            ),
          );
        }
      },
    );
  }

  Future<void> updateArticle({
    required ArticleEntity articleEntity,
    required String name,
    required String description,
    required String code,
    required String color,
    required String price,
  }) async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageArticleListener.loadingUpdate,
      ),
    );
    final result = await articleRepository.updateArticle(
      articleEntity.copyWith(
        articulo: name,
        descripcion: description,
        color: color,
        precio: double.parse(price),
        code: code,
      ),
    );

    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageArticleListener.successUpdate,
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
              dialogMessage: MessageArticleListener.error,
            ),
          );
        }
      },
    );
  }

  Future<void> deleteArticle(int idArticle) async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageArticleListener.loadingDelete,
      ),
    );
    final result = await articleRepository.deleteArticle(idArticle);
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageArticleListener.successDelete,
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
              dialogMessage: MessageArticleListener.error,
            ),
          );
        }
      },
    );
  }
}
