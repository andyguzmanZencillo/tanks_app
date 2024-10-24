part of 'article_delete_cubit.dart';

class ArticleDeleteState extends Equatable {
  const ArticleDeleteState({
    this.deleteStatus = DeleteStatus.initial,
    this.errorMessage,
  });
  final DeleteStatus deleteStatus;
  final String? errorMessage;

  ArticleDeleteState copyWith({
    DeleteStatus? deleteStatus,
    String? errorMessage,
  }) {
    return ArticleDeleteState(
      deleteStatus: deleteStatus ?? this.deleteStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        deleteStatus,
        errorMessage,
      ];
}
