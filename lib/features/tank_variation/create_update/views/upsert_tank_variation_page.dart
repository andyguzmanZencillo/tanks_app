import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/capacity_table/list/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/tank_variation/create_update/cubit/upsert_tank_variation_cubit.dart';
import 'package:tanks_app/features/tank_variation/create_update/helper/upsert_tank_variation_inherited.dart';
import 'package:tanks_app/features/tank_variation/create_update/views/upsert_tank_variation_view.dart';
import 'package:tanks_app/features/tank_variation/list/cubit/tank_variation_cubit.dart';
import 'package:tanks_app/features/tanks/list/cubit/tanks_cubit.dart';
import 'package:tanks_app/injection/injection.dart';

class UpsertTankVariationPage extends StatelessWidget {
  const UpsertTankVariationPage({required this.typeOperation, super.key});
  final TypeOperation typeOperation;

  static Route<bool?> route({
    required TanksCubit tanksCubit,
    required TankVariationCubit tankVariationCubit,
    required TypeOperation typeOperation,
  }) {
    return MaterialPageRoute<bool?>(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: tanksCubit,
          ),
          BlocProvider.value(
            value: tankVariationCubit,
          ),
        ],
        child: UpsertTankVariationPage(
          typeOperation: typeOperation,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tankCubit = context.read<TanksCubit>();
    final tankVariationCubit = context.read<TankVariationCubit>();
    final idTank = tankCubit.state.tankSelected.idTanque;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<UpsertTankVariationCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<CapacityTableCubit>()..getToTank(idTank),
        ),
      ],
      child: UpsertTankVariationInherited(
        tankVariationEntity: tankVariationCubit.state.tankVariationSelected,
        typeOperation: typeOperation,
        child: const UpsertTankVariationView(),
      ),
    );
  }
}
