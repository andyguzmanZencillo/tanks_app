part of 'upsert_tanks_cubit.dart';

class UpsertTanksState extends Equatable {
  const UpsertTanksState({
    this.upsertStatus = UpsertStatus.initial,
    this.prepareStatus = PrepareStatus.initial,
    this.errorMessage,
    this.articles = const [],
    this.consoles = const [],
    this.salesCenters = const [],
    this.statusCheck = true,
    this.modificable = true,
    this.manejaMm = false,
  });

  final UpsertStatus upsertStatus;
  final PrepareStatus prepareStatus;
  final String? errorMessage;

  final List<ArticleEntity> articles;
  final List<ConsoleEntity> consoles;
  final List<SalesCenterEntity> salesCenters;

  final bool statusCheck;
  final bool modificable;
  final bool manejaMm;

  UpsertTanksState copyWith({
    UpsertStatus? upsertStatus,
    PrepareStatus? prepareStatus,
    String? errorMessage,
    List<ArticleEntity>? articles,
    List<ConsoleEntity>? consoles,
    List<SalesCenterEntity>? salesCenters,
    bool? statusCheck,
    bool? modificable,
    bool? manejaMm,
  }) {
    return UpsertTanksState(
      upsertStatus: upsertStatus ?? this.upsertStatus,
      prepareStatus: prepareStatus ?? this.prepareStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      articles: articles ?? this.articles,
      consoles: consoles ?? this.consoles,
      salesCenters: salesCenters ?? this.salesCenters,
      statusCheck: statusCheck ?? this.statusCheck,
      modificable: modificable ?? this.modificable,
      manejaMm: manejaMm ?? this.manejaMm,
    );
  }

  @override
  List<Object?> get props => [
        upsertStatus,
        prepareStatus,
        errorMessage,
        articles,
        consoles,
        salesCenters,
        statusCheck,
        modificable,
        manejaMm,
      ];
}
