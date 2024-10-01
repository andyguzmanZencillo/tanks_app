import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/features/article/article.dart';

part 'article_delete_state.dart';

class ArticleDeleteCubit extends Cubit<ArticleDeleteState> {
  ArticleDeleteCubit(this.articleRepository)
      : super(const ArticleDeleteState());

  final ArticleRepository articleRepository;

  Future<void> deleteArticle(int idArticle) async {
    emit(state.copyWith(deleteArticleStatus: DeleteArticleStatus.loading));
    final result = await articleRepository.deleteArticle(idArticle);
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            deleteArticleStatus: DeleteArticleStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            deleteArticleStatus: DeleteArticleStatus.error,
          ),
        );
      },
    );
  }

  Future<void> udpateStatus(DeleteArticleStatus deleteArticleStatus) async {
    emit(state.copyWith(deleteArticleStatus: deleteArticleStatus));
  }
}
