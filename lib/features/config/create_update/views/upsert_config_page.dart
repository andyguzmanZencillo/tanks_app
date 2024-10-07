import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/config/create_update/cubit/upsert_config_cubit.dart';
import 'package:tanks_app/features/config/create_update/helper/upsert_config_inherited.dart';
import 'package:tanks_app/features/config/create_update/views/upsert_config_view.dart';
import 'package:tanks_app/injection/injection.dart';

class UpsertConfigPage extends StatelessWidget {
  const UpsertConfigPage({required this.typeOperation, super.key});
  final TypeOperation typeOperation;

  static Route<bool?> route({
    required TypeOperation typeOperation,
  }) {
    return MaterialPageRoute<bool?>(
      builder: (context) => UpsertConfigPage(
        typeOperation: typeOperation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<UpsertConfigCubit>(),
        ),
      ],
      child: UpsertConfigInherited(
        typeOperation: typeOperation,
        child: const UpsertConfigView(),
      ),
    );
  }
}
