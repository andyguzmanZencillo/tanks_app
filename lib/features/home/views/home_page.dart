import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/features/binnacle/list/cubit/binnacle_cubit.dart';
import 'package:tanks_app/features/capacity_table/list/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/drawer/views/drawer_view.dart';
import 'package:tanks_app/features/home/dashboard/cubit/dashboard_cubit.dart';
import 'package:tanks_app/features/home/dashboard/widgets/info_date.dart';
import 'package:tanks_app/features/home/widgets/gallons.dart';
import 'package:tanks_app/features/home/widgets/graft_.dart';
import 'package:tanks_app/features/home/widgets/percentage_existence.dart';
import 'package:tanks_app/features/home/widgets/volume.dart';
import 'package:tanks_app/features/sales_center/list/cubit/sales_center_cubit.dart';
import 'package:tanks_app/features/sales_center/list/helpers/sales_center_listener.dart';
import 'package:tanks_app/features/tank_variation/list/cubit/tank_variation_cubit.dart';
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
    final tankCubit = context.read<TanksCubit>();
    final tankVariationCubit = context.read<TankVariationCubit>();
    final dashBoardCubit = context.read<DashboardCubit>();
    final salesCenterCubit = context.read<SalesCenterCubit>();
    final capacityCubit = context.read<CapacityTableCubit>();
    final binacleCubit = context.read<BinnacleCubit>();
    return MultiBlocListener(
      listeners: [
        SalesCenterListener.salesCenter(),
      ],
      child: FullWidgetGeneric(
        onInit: () async {
          if (!(await salesCenterCubit.getAll())) return;
          final sc = salesCenterCubit.state.selected;
          if (!(await tankCubit.getToSaleCenter(sc.idCentroVenta))) return;
          final t = tankCubit.state.selected;

          //----//
          dashBoardCubit.changeDates(
            dateInit: DateTime.now(),
            dateFinal: DateTime.now(),
          );

          unawaited(dashBoardCubit.getToSaleCenter());
          unawaited(
            tankVariationCubit.getBySaleCenterAndTankAndDate(
              idCentroVenta: sc.idCentroVenta,
              idTanque: t.idTanque,
              dateInit: DateTime.now(),
              dateFinal: DateTime.now(),
            ),
          );
          unawaited(capacityCubit.getToTank(t.idTanque));
          unawaited(binacleCubit.getByTank(t.idTanque));
        },
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
              BlocBuilder<BinnacleCubit, BinnacleState>(
                builder: (context, s) {
                  final selected = s.selected;
                  return BlocBuilder<TankVariationCubit, TankVariationState>(
                    builder: (context, state) {
                      if (selected == const BinnacleEntity.empty()) {
                        return const GallonsWidget(
                          speed: 70,
                          maxSpeed: 100,
                        );
                      } else {
                        final maxSpeed = selected.saldo;

                        final speed = state.selected.venta;
                        return GallonsWidget(
                          speed: speed,
                          maxSpeed: maxSpeed,
                        );
                      }
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Porcentage Existencia',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              BlocBuilder<BinnacleCubit, BinnacleState>(
                builder: (context, state) {
                  final selected = state.selected;
                  return BlocBuilder<TanksCubit, TanksState>(
                    builder: (context, state) {
                      final tankSelected = state.selected;
                      if (tankSelected == const TanksEntity.empty()) {
                        return const PercentageExistence(
                          percentage: 20,
                        );
                      }
                      final volumenGalones = selected.saldo;

                      final volumenMax = tankSelected.capacidad;

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
              BlocBuilder<BinnacleCubit, BinnacleState>(
                builder: (context, state) {
                  final capacity = state.list;
                  return BlocBuilder<TanksCubit, TanksState>(
                    builder: (context, state) {
                      final tankSelected = state.selected;
                      if (tankSelected == const TanksEntity.empty()) {
                        return const VolumeWidget(
                          volumenGal: 0,
                          volumenMax: 0,
                        );
                      }
                      final volumenGalones = capacity.firstOrNull?.saldo ?? 0;

                      final volumenMax = tankSelected.capacidad;
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
