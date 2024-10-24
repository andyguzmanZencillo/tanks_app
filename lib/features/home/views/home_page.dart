import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/features/binnacle/list/cubit/binnacle_cubit.dart';
import 'package:tanks_app/features/capacity_table/list/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/drawer/views/drawer_view.dart';
import 'package:tanks_app/features/home/dashboard/cubit/dashboard_cubit.dart';
import 'package:tanks_app/features/home/dashboard/widgets/info_date.dart';
import 'package:tanks_app/features/home/widgets/dialog_home.dart';
import 'package:tanks_app/features/home/widgets/gallons.dart';
import 'package:tanks_app/features/home/widgets/graft_.dart';
import 'package:tanks_app/features/home/widgets/percentage_existence.dart';
import 'package:tanks_app/features/home/widgets/volume.dart';
import 'package:tanks_app/features/sales_center/list/cubit/sales_center_cubit.dart';
import 'package:tanks_app/features/tank_variation/list/cubit/tank_variation_cubit.dart';
import 'package:tanks_app/features/tank_variation/list/helpers/tank_variation_listener.dart';
import 'package:tanks_app/features/tanks/list/cubit/tanks_cubit.dart';
import 'package:tanks_app/injection/injection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (context) => const HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<TankVariationCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<SalesCenterCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<TanksCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<DashboardCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<CapacityTableCubit>(),
        ),
        BlocProvider(create: (context) => sl<BinnacleCubit>()),
      ],
      child: const HomeViesw(),
    );
  }
}

class HomeViesw extends StatelessWidget {
  const HomeViesw({super.key});

  @override
  Widget build(BuildContext context) {
    final cubitTank = context.read<TanksCubit>();
    final tankVariationCubit = context.read<TankVariationCubit>();
    final dashBoardCubit = context.read<DashboardCubit>();
    final salesCenterCubit = context.read<SalesCenterCubit>();
    final capacityCubit = context.read<CapacityTableCubit>();
    return MultiBlocListener(
      listeners: [
        TankVariationListener.salesCenter(),
        TankVariationListener.event(
          success: () {
            showDialog<bool>(
              context: context,
              builder: (context) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: cubitTank),
                    BlocProvider.value(value: dashBoardCubit),
                    BlocProvider.value(value: salesCenterCubit),
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
        ),
        //TankVariationListener.tanks(),
        TankVariationListener.tankVariation(),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          context.read<SalesCenterCubit>().getAll();
          context.read<BinnacleCubit>().getAll();
        },
        onDispose: () {},
        child: const HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      drawer: const DrawerPage(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const InfoDashBoard(),
              const SizedBox(
                height: 10,
              ),
              const Graft(),
              const Text(
                'Volumen venta',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<DashboardCubit, DashboardState>(
                builder: (context, state) {
                  final bitacora = state.list.firstOrNull;
                  if (bitacora == null) {
                    return const GallonsWidget(
                      speed: 70,
                      maxSpeed: 100,
                    );
                  } else {
                    final maxSpeed = bitacora.saldoInicial +
                        bitacora.descargue +
                        bitacora.venta;

                    final speed = bitacora.saldoInicial + bitacora.descargue;
                    return GallonsWidget(
                      speed: speed,
                      maxSpeed: maxSpeed,
                    );
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Porcentage Existencia',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              BlocBuilder<CapacityTableCubit, CapacityTableState>(
                builder: (context, state) {
                  final capacity = state.capacityEntitys;
                  return BlocBuilder<DashboardCubit, DashboardState>(
                    builder: (context, state) {
                      final bitacora = state.list.firstOrNull;
                      if (bitacora == null) {
                        return const PercentageExistence(
                          percentage: 20,
                        );
                      }
                      final volumenGalones = bitacora.inventarioFinalCalculado -
                          bitacora.venta +
                          bitacora.descargue;

                      final volumenMax = capacity.lastOrNull?.volumen ?? 0;

                      final percentage = (volumenGalones * 100) / volumenMax;
                      return PercentageExistence(
                        percentage:
                            percentage == double.infinity ? 0 : percentage,
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<CapacityTableCubit, CapacityTableState>(
                builder: (context, state) {
                  final capacity = state.capacityEntitys;
                  return BlocBuilder<DashboardCubit, DashboardState>(
                    builder: (context, state) {
                      final bitacora = state.list.firstOrNull;
                      if (bitacora == null) {
                        return const VolumeWidget(
                          volumenGal: 0,
                          volumenMax: 0,
                        );
                      }
                      final volumenGalones = bitacora.inventarioFinalCalculado -
                          bitacora.venta +
                          bitacora.descargue;

                      final volumenMax = capacity.lastOrNull?.volumen ?? 0;
                      return VolumeWidget(
                        volumenGal: volumenGalones,
                        volumenMax: volumenMax,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
