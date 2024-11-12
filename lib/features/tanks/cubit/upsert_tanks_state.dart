part of 'upsert_tanks_cubit.dart';

class UpsertTanksState extends Equatable implements StatusState {
  const UpsertTanksState({
    this.articles = const [],
    this.consoles = const [],
    this.salesCenters = const [],
    this.statusCheck = true,
    this.modificable = true,
    this.manejaMm = false,
    this.generalStatus = GeneralStatus.initial,
    this.dialogMessage = const DialogMessage.empty(),
  });

  final List<ArticleEntity> articles;
  final List<ConsoleEntity> consoles;
  final List<SalesCenterEntity> salesCenters;

  final bool statusCheck;
  final bool modificable;
  final bool manejaMm;

  @override
  final GeneralStatus generalStatus;

  @override
  final DialogMessage dialogMessage;

  UpsertTanksState copyWith({
    List<ArticleEntity>? articles,
    List<ConsoleEntity>? consoles,
    List<SalesCenterEntity>? salesCenters,
    bool? statusCheck,
    bool? modificable,
    bool? manejaMm,
    GeneralStatus? generalStatus,
    DialogMessage? dialogMessage,
  }) {
    return UpsertTanksState(
      articles: articles ?? this.articles,
      consoles: consoles ?? this.consoles,
      salesCenters: salesCenters ?? this.salesCenters,
      statusCheck: statusCheck ?? this.statusCheck,
      modificable: modificable ?? this.modificable,
      manejaMm: manejaMm ?? this.manejaMm,
      generalStatus: generalStatus ?? this.generalStatus,
      dialogMessage: dialogMessage ?? this.dialogMessage,
    );
  }

  @override
  List<Object?> get props => [
        articles,
        consoles,
        salesCenters,
        statusCheck,
        modificable,
        manejaMm,
        generalStatus,
        dialogMessage,
      ];
}
