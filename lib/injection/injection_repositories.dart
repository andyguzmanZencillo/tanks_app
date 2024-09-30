import 'package:get_it/get_it.dart';
import 'package:tank_repository/features/article/repository/article_repository.dart';
import 'package:tank_repository/tank_repository.dart';

final sl = GetIt.instance;

void registerRepositories() {
  sl.registerLazySingleton<CompanyRepository>(CompanyRepository.new);
  sl.registerLazySingleton<UserRepository>(UserRepository.new);
  sl.registerLazySingleton<ArticleRepository>(ArticleRepository.new);
}
