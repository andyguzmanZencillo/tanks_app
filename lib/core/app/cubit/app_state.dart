part of 'app_cubit.dart';

enum AppStatus { loged, error, noLoged, initial }

class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.initial,
    this.errorMessage = '',
  });

  final AppStatus status;
  final String errorMessage;

  AppState copyWith({
    AppStatus? status,
    String? errorMessage,
  }) {
    return AppState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, errorMessage];
}
