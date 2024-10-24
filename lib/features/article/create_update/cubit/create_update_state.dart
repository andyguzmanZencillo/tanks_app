part of 'create_update_cubit.dart';

class CreateUpdateState extends Equatable {
  const CreateUpdateState({
    this.upsertStatus = UpsertStatus.initial,
    this.errorMessage,
  });

  final UpsertStatus upsertStatus;
  final String? errorMessage;

  CreateUpdateState copyWith({
    UpsertStatus? upsertStatus,
    String? errorMessage,
  }) {
    return CreateUpdateState(
      upsertStatus: upsertStatus ?? this.upsertStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        upsertStatus,
        errorMessage,
      ];
}
