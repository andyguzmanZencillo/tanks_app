import 'package:get_it/get_it.dart';
import 'package:tanks_app/core/app/app.dart';
import 'package:tanks_app/core/helpers/token/token_cubit.dart';
import 'package:tanks_app/core/helpers/user_device/cubit/user_device_cubit.dart';
import 'package:tanks_app/features/article/cubit/article_cubit.dart';
import 'package:tanks_app/features/binnacle/list/cubit/binnacle_cubit.dart';
import 'package:tanks_app/features/capacity_table/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/capacity_table/cubit/upsert_capacity_table_cubit.dart';
import 'package:tanks_app/features/company/cubit/company_cubit.dart';
import 'package:tanks_app/features/config/cubit/config_cubit.dart';
import 'package:tanks_app/features/console/cubit/console_cubit.dart';
import 'package:tanks_app/features/console_protocol/cubit/console_cubit.dart';
import 'package:tanks_app/features/home/dashboard/cubit/dashboard_cubit.dart';
import 'package:tanks_app/features/profile/alert/cubit/alert_cubit.dart';
import 'package:tanks_app/features/profile/config_notification/cubit/config_notification_cubit.dart';
import 'package:tanks_app/features/profile/notification/notification_cubit.dart';
import 'package:tanks_app/features/profile/perfil/cubit/perfil_cubit.dart';
import 'package:tanks_app/features/profile/user_alert/user_alert_cubit.dart';
import 'package:tanks_app/features/profile/user_notification/notification_cubit.dart';
import 'package:tanks_app/features/sales_center/cubit/sales_center_cubit.dart';
import 'package:tanks_app/features/session/session_cubit.dart';
import 'package:tanks_app/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:tanks_app/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:tanks_app/features/tank_variation/create_update/cubit/upsert_tank_variation_cubit.dart';
import 'package:tanks_app/features/tank_variation/list/cubit/tank_variation_cubit.dart';
import 'package:tanks_app/features/tanks/cubit/tanks_cubit.dart';
import 'package:tanks_app/features/tanks/cubit/upsert_tanks_cubit.dart';

final sl = GetIt.instance;

void registerBloc() {
  sl.registerFactory<AppCubit>(
    () => AppCubit(sl()),
  );
  sl.registerFactory<CompanyCubit>(
    () => CompanyCubit(sl()),
  );
  sl.registerFactory<SignInCubit>(
    () => SignInCubit(sl()),
  );
  sl.registerFactory<SignUpCubit>(
    () => SignUpCubit(sl()),
  );

  sl.registerFactory<SalesCenterCubit>(
    () => SalesCenterCubit(sl()),
  );

  sl.registerFactory<ConsoleCubit>(
    () => ConsoleCubit(sl()),
  );
  sl.registerFactory<TanksCubit>(
    () => TanksCubit(sl()),
  );
  sl.registerFactory<UpsertTanksCubit>(
    () => UpsertTanksCubit(sl(), sl()),
  );

  sl.registerFactory<CapacityTableCubit>(
    () => CapacityTableCubit(sl()),
  );
  sl.registerFactory<UpsertCapacityTableCubit>(
    () => UpsertCapacityTableCubit(sl()),
  );
  sl.registerFactory<TankVariationCubit>(
    () => TankVariationCubit(sl()),
  );
  sl.registerFactory<UpsertTankVariationCubit>(
    () => UpsertTankVariationCubit(sl()),
  );
  sl.registerFactory<ConfigCubit>(
    () => ConfigCubit(sl()),
  );

  sl.registerFactory<BinnacleCubit>(
    () => BinnacleCubit(sl()),
  );
  sl.registerFactory<DashboardCubit>(
    () => DashboardCubit(sl()),
  );
  sl.registerFactory<SessionCubit>(
    () => SessionCubit(sl()),
  );
  sl.registerFactory<UserNotificationCubit>(
    () => UserNotificationCubit(sl()),
  );
  sl.registerFactory<UserAlertCubit>(
    () => UserAlertCubit(sl()),
  );
  sl.registerFactory<PerfilCubit>(
    () => PerfilCubit(sl()),
  );
  sl.registerFactory<AlertCubit>(
    () => AlertCubit(sl()),
  );
  sl.registerFactory<UserDeviceCubit>(
    () => UserDeviceCubit(sl()),
  );
  sl.registerFactory<NotificationCubit>(
    () => NotificationCubit(sl()),
  );
  sl.registerFactory<ConfigNotificationCubit>(
    () => ConfigNotificationCubit(sl()),
  );
  sl.registerFactory<TokenCubit>(
    () => TokenCubit(sl()),
  );

  sl.registerFactory<ConsoleProtocolCubit>(
    () => ConsoleProtocolCubit(sl()),
  );

  sl.registerFactory<ArticleCubit>(() => ArticleCubit(sl()));
}
