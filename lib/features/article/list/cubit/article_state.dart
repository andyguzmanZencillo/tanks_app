part of 'article_cubit.dart';

enum ArticleStatus { loading, success, successDelete, error, initial }

class ArticleState extends Equatable {
  const ArticleState({
    this.articleStatus = ArticleStatus.initial,
    this.articles = const [],
  });
  final ArticleStatus articleStatus;
  final List<ArticleEntity> articles;

  ArticleState copyWith({
    ArticleStatus? articleStatus,
    List<ArticleEntity>? articles,
  }) {
    return ArticleState(
      articleStatus: articleStatus ?? this.articleStatus,
      articles: articles ?? this.articles,
    );
  }

  @override
  List<Object> get props => [articleStatus, articles];
}
