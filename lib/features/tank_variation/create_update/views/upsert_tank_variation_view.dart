import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/features/article/helpers/create_update_inherited.dart';
import 'package:tanks_app/features/capacity_table/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/tank_variation/create_update/helper/upsert_tank_variation_inherited.dart';
import 'package:tanks_app/features/tank_variation/create_update/helper/upsert_tank_variation_listener.dart';
import 'package:tanks_app/features/tank_variation/create_update/views/upsert_tank_variation_body.dart';
import 'package:tanks_app/features/tank_variation/list/cubit/tank_variation_cubit.dart';

class UpsertTankVariationView extends StatelessWidget {
  const UpsertTankVariationView({super.key});

  @override
  Widget build(BuildContext context) {
    final tankVariationCubit = context.read<TankVariationCubit>();
    final capacityCubit = context.read<CapacityTableCubit>();

    final inherited = UpsertTankVariationInherited.of(context);
    return MultiBlocListener(
      listeners: [
        UpsertTanksVariationListener.upsertTankVariation(),
        ListenerPro<CapacityTableCubit, CapacityTableState>().listen(),
      ],
      child: FullWidgetGeneric(
        onInit: () async {
          await capacityCubit.getToTank(
            tankVariationCubit.state.selectedPro.tank.idTanque,
          );
          if (inherited.typeOperation == TypeOperation.update) {
            inherited.setData(tankVariationCubit.state.selectedPro);
          }
          inherited.setDataLast();
        },
        child: const UpsertTankVariationBody(),
      ),
    );
  }
}
