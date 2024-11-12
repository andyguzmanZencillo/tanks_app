part of 'config_cubit.dart';

class ConfigState extends Equatable implements StatusState {
  const ConfigState({
    this.generalStatus = GeneralStatus.initial,
    this.configurations = const [],
    this.configSelected = const ConfigEntity.empty(),
    this.dialogMessage = const DialogMessage.empty(),
  });

  @override
  final GeneralStatus generalStatus;
  final ConfigEntity configSelected;
  final List<ConfigEntity> configurations;

  @override
  final DialogMessage dialogMessage;

  ConfigState copyWith({
    GeneralStatus? generalStatus,
    List<ConfigEntity>? configurations,
    ConfigEntity? configSelected,
    DialogMessage? dialogMessage,
  }) {
    return ConfigState(
      generalStatus: generalStatus ?? this.generalStatus,
      configurations: configurations ?? this.configurations,
      configSelected: configSelected ?? this.configSelected,
      dialogMessage: dialogMessage ?? this.dialogMessage,
    );
  }

  @override
  List<Object?> get props => [
        generalStatus,
        configurations,
        configSelected,
        dialogMessage,
      ];
}
