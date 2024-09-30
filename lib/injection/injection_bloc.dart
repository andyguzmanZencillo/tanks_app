import 'package:get_it/get_it.dart';
import 'package:tanks_app/features/article/create_update/cubit/create_update_cubit.dart';
import 'package:tanks_app/features/article/list/cubit/article_cubit.dart';
import 'package:tanks_app/features/company/cubit/company_cubit.dart';
import 'package:tanks_app/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:tanks_app/features/sign_up/cubit/sign_up_cubit.dart';

final sl = GetIt.instance;

void registerBloc() {
  sl.registerFactory<CompanyCubit>(() => CompanyCubit(sl()));
  sl.registerFactory<SignInCubit>(() => SignInCubit(sl()));
  sl.registerFactory<SignUpCubit>(() => SignUpCubit(sl()));
  sl.registerFactory<ArticleCubit>(() => ArticleCubit(sl()));
  sl.registerFactory<CreateUpdateCubit>(() => CreateUpdateCubit(sl()));
}
