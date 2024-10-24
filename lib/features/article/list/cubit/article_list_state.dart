part of 'article_list_cubit.dart';

class ArticleListState extends Equatable {
  const ArticleListState({
    this.generalStatus = GeneralStatus.initial,
    this.list = const [],
    this.listCopy = const [],
    this.selected = const ArticleEntity.empty(),
    this.errorMessage,
  });

  final GeneralStatus generalStatus;
  final List<ArticleEntity> list;
  final List<ArticleEntity> listCopy;
  final ArticleEntity selected;
  final String? errorMessage;

  ArticleListState copyWith({
    GeneralStatus? generalStatus,
    List<ArticleEntity>? list,
    List<ArticleEntity>? listCopy,
    ArticleEntity? selected,
    String? errorMessage,
  }) {
    return ArticleListState(
      generalStatus: generalStatus ?? this.generalStatus,
      list: list ?? this.list,
      listCopy: listCopy ?? this.listCopy,
      selected: selected ?? this.selected,
      errorMessage: errorMessage ?? errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        generalStatus,
        list,
        listCopy,
        errorMessage,
        selected,
      ];
}
