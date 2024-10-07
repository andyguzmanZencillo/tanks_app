part of 'config_cubit.dart';

class ConfigState extends Equatable {
  const ConfigState({
    this.generalStatus = GeneralStatus.initial,
    this.configurations = const [],
    this.configSelected = const ConfigEntity.empty(),
    this.errorMessage,
  });
  final GeneralStatus generalStatus;
  final ConfigEntity configSelected;
  final List<ConfigEntity> configurations;
  final String? errorMessage;

  ConfigState copyWith({
    GeneralStatus? generalStatus,
    List<ConfigEntity>? configurations,
    ConfigEntity? configSelected,
    String? errorMessage,
  }) {
    return ConfigState(
      generalStatus: generalStatus ?? this.generalStatus,
      configurations: configurations ?? this.configurations,
      configSelected: configSelected ?? this.configSelected,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        generalStatus,
        configurations,
        configSelected,
        errorMessage,
      ];
}
