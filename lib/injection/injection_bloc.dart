import 'package:get_it/get_it.dart';
import 'package:tanks_app/core/app/app.dart';
import 'package:tanks_app/features/article/create_update/cubit/create_update_cubit.dart';
import 'package:tanks_app/features/article/delete/cubit/article_delete_cubit.dart';
import 'package:tanks_app/features/article/list/cubit/article_cubit.dart';
import 'package:tanks_app/features/company/cubit/company_cubit.dart';
import 'package:tanks_app/features/console/create_update/cubit/upsert_console_cubit.dart';
import 'package:tanks_app/features/console/delete/cubit/delete_console_cubit.dart';
import 'package:tanks_app/features/console/list/cubit/console_cubit.dart';
import 'package:tanks_app/features/sales_center/create_update/cubit/upsert_sales_center_cubit.dart';
import 'package:tanks_app/features/sales_center/delete/cubit/delete_sales_center_cubit.dart';
import 'package:tanks_app/features/sales_center/list/cubit/sales_center_cubit.dart';
import 'package:tanks_app/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:tanks_app/features/sign_up/cubit/sign_up_cubit.dart';

final sl = GetIt.instance;

void registerBloc() {
  sl.registerFactory<AppCubit>(() => AppCubit(sl()));
  sl.registerFactory<CompanyCubit>(() => CompanyCubit(sl()));
  sl.registerFactory<SignInCubit>(() => SignInCubit(sl()));
  sl.registerFactory<SignUpCubit>(() => SignUpCubit(sl()));
  sl.registerFactory<ArticleCubit>(() => ArticleCubit(sl()));
  sl.registerFactory<CreateUpdateCubit>(() => CreateUpdateCubit(sl()));
  sl.registerFactory<ArticleDeleteCubit>(() => ArticleDeleteCubit(sl()));

  //Sale center
  sl.registerFactory<SalesCenterCubit>(() => SalesCenterCubit(sl()));
  sl.registerFactory<UpsertSalesCenterCubit>(
    () => UpsertSalesCenterCubit(sl()),
  );
  sl.registerFactory<DeleteSalesCenterCubit>(
    () => DeleteSalesCenterCubit(sl()),
  );
  //Console
  sl.registerFactory<ConsoleCubit>(() => ConsoleCubit(sl()));
  sl.registerFactory<UpsertConsoleCubit>(
    () => UpsertConsoleCubit(sl()),
  );
  sl.registerFactory<DeleteConsoleCubit>(
    () => DeleteConsoleCubit(sl()),
  );
}
