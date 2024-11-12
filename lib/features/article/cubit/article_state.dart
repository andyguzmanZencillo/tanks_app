part of 'article_cubit.dart';

class ArticleState extends Equatable implements StatusState {
  const ArticleState({
    this.generalStatus = GeneralStatus.initial,
    this.list = const [],
    this.listCopy = const [],
    this.selected = const ArticleEntity.empty(),
    this.dialogMessage = const DialogMessage.empty(),
  });

  @override
  final GeneralStatus generalStatus;
  @override
  final DialogMessage dialogMessage;

  final List<ArticleEntity> list;
  final List<ArticleEntity> listCopy;
  final ArticleEntity selected;

  ArticleState copyWith({
    GeneralStatus? generalStatus,
    List<ArticleEntity>? list,
    List<ArticleEntity>? listCopy,
    ArticleEntity? selected,
    DialogMessage? dialogMessage,
  }) {
    return ArticleState(
      generalStatus: generalStatus ?? this.generalStatus,
      list: list ?? this.list,
      listCopy: listCopy ?? this.listCopy,
      selected: selected ?? this.selected,
      dialogMessage: dialogMessage ?? this.dialogMessage,
    );
  }

  @override
  List<Object?> get props => [
        generalStatus,
        list,
        listCopy,
        selected,
        dialogMessage,
      ];
}
