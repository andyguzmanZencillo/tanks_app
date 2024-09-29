import 'package:get_it/get_it.dart';
import 'package:tanks_app/injection/injection_bloc.dart';
import 'package:tanks_app/injection/injection_repositories.dart';

final sl = GetIt.instance;
void injectDependencies() {
  registerRepositories();
  registerBloc();
}
