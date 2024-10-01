import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/features/article/article.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit(this.articleRepository) : super(const ArticleState());

  final ArticleRepository articleRepository;

  Future<void> getArticles() async {
    emit(state.copyWith(articleStatus: ArticleStatus.success));
    final result = await articleRepository.getArticles();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            articles: ok,
            articleStatus: ArticleStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            articles: [],
            articleStatus: ArticleStatus.error,
          ),
        );
      },
    );
  }

  Future<void> deleteArticle(int idArticle) async {
    emit(state.copyWith(articleStatus: ArticleStatus.success));
    final result = await articleRepository.deleteArticle(idArticle);
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            articleStatus: ArticleStatus.successDelete,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            articleStatus: ArticleStatus.error,
          ),
        );
      },
    );
  }
}
