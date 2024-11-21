part of 'prepare_tank_cubit.dart';

class PrepareTankState extends Equatable implements StatusState {
  const PrepareTankState({
    this.articles = const [],
    this.selectedArticle,
    this.consoles = const [],
    this.selectedConsole,
    this.salesCenters = const [],
    this.selectedSalesCenter,
    this.generalStatus = GeneralStatus.initial,
    this.dialogMessage = const DialogMessage.empty(),
  });

  final List<ArticleEntity> articles;
  final ArticleEntity? selectedArticle;

  final List<ConsoleEntity> consoles;
  final ConsoleEntity? selectedConsole;

  final List<SalesCenterEntity> salesCenters;
  final SalesCenterEntity? selectedSalesCenter;

  @override
  final GeneralStatus generalStatus;

  @override
  final DialogMessage dialogMessage;

  PrepareTankState copyWith({
    List<ArticleEntity>? articles,
    ArticleEntity? selectedArticle,
    List<ConsoleEntity>? consoles,
    ConsoleEntity? selectedConsole,
    List<SalesCenterEntity>? salesCenters,
    SalesCenterEntity? selectedSalesCenter,
    GeneralStatus? generalStatus,
    DialogMessage? dialogMessage,
  }) {
    return PrepareTankState(
      articles: articles ?? this.articles,
      selectedArticle: selectedArticle ?? this.selectedArticle,
      consoles: consoles ?? this.consoles,
      selectedConsole: selectedConsole ?? this.selectedConsole,
      salesCenters: salesCenters ?? this.salesCenters,
      selectedSalesCenter: selectedSalesCenter ?? this.selectedSalesCenter,
      generalStatus: generalStatus ?? this.generalStatus,
      dialogMessage: dialogMessage ?? this.dialogMessage,
    );
  }

  @override
  List<Object?> get props => [
        articles,
        selectedArticle,
        consoles,
        selectedConsole,
        salesCenters,
        selectedSalesCenter,
        generalStatus,
        dialogMessage,
      ];
}
