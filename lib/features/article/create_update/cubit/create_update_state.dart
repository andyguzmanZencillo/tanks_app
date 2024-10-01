part of 'create_update_cubit.dart';

class CreateUpdateState extends Equatable {
  const CreateUpdateState({
    this.articleStatus = UpsertStatus.initial,
  });
  final UpsertStatus articleStatus;

  CreateUpdateState copyWith({
    UpsertStatus? articleStatus,
  }) {
    return CreateUpdateState(
      articleStatus: articleStatus ?? this.articleStatus,
    );
  }

  @override
  List<Object> get props => [
        articleStatus,
      ];
}
