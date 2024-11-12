import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/features/article/helpers/create_update_inherited.dart';
import 'package:tanks_app/features/capacity_table/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/tank_variation/create_update/cubit/upsert_tank_variation_cubit.dart';
import 'package:tanks_app/features/tank_variation/create_update/helper/upsert_tank_variation_inherited.dart';
import 'package:tanks_app/features/tank_variation/create_update/views/upsert_tank_variation_view.dart';
import 'package:tanks_app/injection/injection.dart';

class UpsertTankVariationPage extends StatelessWidget {
  const UpsertTankVariationPage({required this.typeOperation, super.key});
  final TypeOperation typeOperation;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<UpsertTankVariationCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<CapacityTableCubit>(),
        ),
      ],
      child: UpsertTankVariationInherited(
        typeOperation: typeOperation,
        child: const UpsertTankVariationView(),
      ),
    );
  }
}
