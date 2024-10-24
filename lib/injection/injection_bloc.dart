import 'package:get_it/get_it.dart';
import 'package:tanks_app/core/app/app.dart';
import 'package:tanks_app/core/helpers/user_device/cubit/user_device_cubit.dart';
import 'package:tanks_app/features/article/create_update/cubit/create_update_cubit.dart';
import 'package:tanks_app/features/article/delete/cubit/article_delete_cubit.dart';
import 'package:tanks_app/features/article/list/cubit/article_list_cubit.dart';
import 'package:tanks_app/features/binnacle/list/cubit/binnacle_cubit.dart';
import 'package:tanks_app/features/capacity_table/create_update/cubit/upsert_capacity_table_cubit.dart';
import 'package:tanks_app/features/capacity_table/list/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/company/cubit/company_cubit.dart';
import 'package:tanks_app/features/config/create_update/cubit/upsert_config_cubit.dart';
import 'package:tanks_app/features/config/delete/cubit/delete_config_cubit.dart';
import 'package:tanks_app/features/config/list/cubit/config_cubit.dart';
import 'package:tanks_app/features/console/create_update/cubit/upsert_console_cubit.dart';
import 'package:tanks_app/features/console/delete/cubit/delete_console_cubit.dart';
import 'package:tanks_app/features/console/list/cubit/console_cubit.dart';
import 'package:tanks_app/features/home/dashboard/cubit/dashboard_cubit.dart';
import 'package:tanks_app/features/profile/config_notification/cubit/config_notification_cubit.dart';
import 'package:tanks_app/features/profile/get_alert/get_alert_cubit.dart';
import 'package:tanks_app/features/profile/get_notification/get_notification_cubit.dart';
import 'package:tanks_app/features/profile/get_user_alert/get_user_alert_cubit.dart';
import 'package:tanks_app/features/profile/get_user_notification/get_notification_cubit.dart';
import 'package:tanks_app/features/profile/perfil/cubit/perfil_cubit.dart';
import 'package:tanks_app/features/sales_center/create_update/cubit/upsert_sales_center_cubit.dart';
import 'package:tanks_app/features/sales_center/delete/cubit/delete_sales_center_cubit.dart';
import 'package:tanks_app/features/sales_center/list/cubit/sales_center_cubit.dart';
import 'package:tanks_app/features/session/session_cubit.dart';
import 'package:tanks_app/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:tanks_app/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:tanks_app/features/tank_variation/create_update/cubit/upsert_tank_variation_cubit.dart';
import 'package:tanks_app/features/tank_variation/list/cubit/tank_variation_cubit.dart';
import 'package:tanks_app/features/tanks/create_update/cubit/upsert_tanks_cubit.dart';
import 'package:tanks_app/features/tanks/delete/cubit/delete_tanks_cubit.dart';
import 'package:tanks_app/features/tanks/list/cubit/tanks_cubit.dart';

final sl = GetIt.instance;

void registerBloc() {
  sl.registerFactory<AppCubit>(() => AppCubit(sl()));
  sl.registerFactory<CompanyCubit>(() => CompanyCubit(sl()));
  sl.registerFactory<SignInCubit>(() => SignInCubit(sl()));
  sl.registerFactory<SignUpCubit>(() => SignUpCubit(sl()));
  sl.registerFactory<ArticleListCubit>(() => ArticleListCubit(sl()));
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
  //Tanques
  sl.registerFactory<TanksCubit>(() => TanksCubit(sl()));
  sl.registerFactory<UpsertTanksCubit>(
    () => UpsertTanksCubit(sl()),
  );
  sl.registerFactory<DeleteTanksCubit>(
    () => DeleteTanksCubit(sl()),
  );

  //Aforo
  sl.registerFactory<CapacityTableCubit>(() => CapacityTableCubit(sl()));
  sl.registerFactory<UpsertCapacityTableCubit>(
    () => UpsertCapacityTableCubit(sl()),
  );
  /*sl.registerFactory<DeleteCapacityTableCubit>(
    () => DeleteCapacityTableCubit(sl()),
  );*/
  sl.registerFactory<TankVariationCubit>(() => TankVariationCubit(sl()));
  sl.registerFactory<UpsertTankVariationCubit>(
    () => UpsertTankVariationCubit(
      sl(),
    ),
  );
  sl.registerFactory<ConfigCubit>(() => ConfigCubit(sl()));
  sl.registerFactory<UpsertConfigCubit>(() => UpsertConfigCubit(sl()));
  sl.registerFactory<DeleteConfigCubit>(() => DeleteConfigCubit(sl()));
  sl.registerFactory<BinnacleCubit>(() => BinnacleCubit(sl()));

  sl.registerFactory<DashboardCubit>(() => DashboardCubit(sl()));
  sl.registerFactory<SessionCubit>(() => SessionCubit(sl()));
  sl.registerFactory<GetUserNotificationCubit>(
    () => GetUserNotificationCubit(sl()),
  );

  sl.registerFactory<GetUserAlertCubit>(() => GetUserAlertCubit(sl()));
  sl.registerFactory<PerfilCubit>(() => PerfilCubit(sl()));

  sl.registerFactory<GetAlertCubit>(() => GetAlertCubit(sl()));
  sl.registerFactory<UserDeviceCubit>(() => UserDeviceCubit(sl()));
  sl.registerFactory<GetNotificationCubit>(() => GetNotificationCubit(sl()));
  sl.registerFactory<ConfigNotificationCubit>(
    () => ConfigNotificationCubit(sl()),
  );
}
