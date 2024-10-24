import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/util/extensions/extension_date.dart';
import 'package:tanks_app/features/capacity_table/list/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/home/dashboard/cubit/dashboard_cubit.dart';
import 'package:tanks_app/features/home/widgets/dialog_home.dart';
import 'package:tanks_app/features/sales_center/list/cubit/sales_center_cubit.dart';
import 'package:tanks_app/features/tank_variation/list/cubit/tank_variation_cubit.dart';
import 'package:tanks_app/features/tanks/list/cubit/tanks_cubit.dart';

class InfoDashBoard extends StatelessWidget {
  const InfoDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final dashBoard = context.read<DashboardCubit>();
    final cubitTank = context.read<TanksCubit>();
    final tankVariationCubit = context.read<TankVariationCubit>();
    final dashBoardCubit = context.read<DashboardCubit>();
    final salesCenterCubit = context.read<SalesCenterCubit>();
    final capacityCubit = context.read<CapacityTableCubit>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: BlueStoneColors.blueStone100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocSelector<SalesCenterCubit, SalesCenterState, SalesCenterEntity>(
            selector: (state) => state.selected,
            builder: (context, state) {
              return Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Centro de venta:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        state.descripcion,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider.value(value: cubitTank),
                              BlocProvider.value(value: dashBoardCubit),
                              BlocProvider.value(
                                value: salesCenterCubit,
                              ),
                              BlocProvider.value(value: capacityCubit),
                              BlocProvider.value(
                                value: tankVariationCubit,
                              ),
                            ],
                            child: const DialogHome(),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      FluentIcons.settings_16_regular,
                      size: 29,
                      color: BlueStoneColors.blueStone600,
                    ),
                  ),
                ],
              );
            },
          ),
          BlocSelector<TanksCubit, TanksState, TanksEntity>(
            selector: (state) => state.selected,
            builder: (context, state) {
              return Row(
                children: [
                  const Text(
                    'Tanque:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    state.descripcion,
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Fecha inicio:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            dashBoard.state.dateInit?.literalDate() ??
                                DateTime.now().literalDate(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Fecha final:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            dashBoard.state.dateFinal?.literalDate() ??
                                DateTime.now().literalDate(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
