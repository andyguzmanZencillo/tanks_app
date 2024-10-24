import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/features/article/article.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'article_delete_state.dart';

class ArticleDeleteCubit extends Cubit<ArticleDeleteState> {
  ArticleDeleteCubit(this.articleRepository)
      : super(const ArticleDeleteState());

  final ArticleRepository articleRepository;

  Future<void> deleteArticle(int idArticle) async {
    emit(state.copyWith(deleteStatus: DeleteStatus.loading));
    final result = await articleRepository.deleteArticle(idArticle);
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            deleteStatus: DeleteStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            deleteStatus: DeleteStatus.error,
          ),
        );
      },
    );
  }

  Future<void> udpateStatus(DeleteStatus deleteArticleStatus) async {
    emit(state.copyWith(deleteStatus: deleteArticleStatus));
  }
}
