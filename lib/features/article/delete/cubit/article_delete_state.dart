part of 'article_delete_cubit.dart';

enum DeleteArticleStatus { loading, success, error, initial }

class ArticleDeleteState extends Equatable {
  const ArticleDeleteState({
    this.deleteArticleStatus = DeleteArticleStatus.initial,
  });
  final DeleteArticleStatus deleteArticleStatus;

  ArticleDeleteState copyWith({
    DeleteArticleStatus? deleteArticleStatus,
  }) {
    return ArticleDeleteState(
      deleteArticleStatus: deleteArticleStatus ?? this.deleteArticleStatus,
    );
  }

  @override
  List<Object> get props => [
        deleteArticleStatus,
      ];
}
