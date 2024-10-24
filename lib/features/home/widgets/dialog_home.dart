import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';
import 'package:tank_repository/features/tanks/entity/tanks_entity.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/features/capacity_table/list/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/home/dashboard/cubit/dashboard_cubit.dart';
import 'package:tanks_app/features/home/widgets/date_picker_home.dart';
import 'package:tanks_app/features/home/widgets/dropdown_sales_center.dart';
import 'package:tanks_app/features/sales_center/list/cubit/sales_center_cubit.dart';
import 'package:tanks_app/features/tank_variation/list/cubit/tank_variation_cubit.dart';
import 'package:tanks_app/features/tanks/list/cubit/tanks_cubit.dart';

class DialogHome extends StatelessWidget {
  const DialogHome({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerDateInicial = ControllerFieldDatePicker();
    final controllerDateFinal = ControllerFieldDatePicker();
    final controllerDropdown = ControllerFieldDropdown();

    final cubitTank = context.read<TanksCubit>();
    final dashBoardCubit = context.read<DashboardCubit>();
    final tankVariationCubit = context.read<TankVariationCubit>();
    final saleCenterCubit = context.read<SalesCenterCubit>();
    final capacityCubit = context.read<CapacityTableCubit>();

    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: const Text(
        'Filtro dahsboard',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocSelector<SalesCenterCubit, SalesCenterState,
                List<SalesCenterEntity>>(
              selector: (state) {
                return state.list;
              },
              builder: (context, state) {
                if (state.isEmpty) {
                  return const SizedBox.shrink();
                }
                SalesCenterEntity? item;
                if (saleCenterCubit.state.selected !=
                    const SalesCenterEntity.empty()) {
                  item = saleCenterCubit.state.selected;
                }

                return DropdownSalesCenter<SalesCenterEntity>(
                  controller: ControllerFieldDropdown(),
                  validator: (p0) {
                    if (p0 == null) {
                      return 'Valor requerido';
                    }
                    return null;
                  },
                  label: 'Centro de venta',
                  hint: 'Centro de venta',
                  showDecoration: false,
                  value: item,
                  isLabelTitle: false,
                  items: state,
                  onChanged: (p0) {
                    saleCenterCubit.changeSelected(p0.value!);
                    cubitTank.changeSelected(const TanksEntity.empty());
                    cubitTank.getToSaleCenter(p0.id);
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<TanksCubit, TanksState>(
              builder: (context, state) {
                if (state.tanksStatus == TanksStatus.initial) {
                  return const Center(
                    child: Text(
                      'Seleccione un centro de venta para aplicar los filtros',
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (state.tanksStatus == TanksStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: BlueStoneColors.blueStone600,
                    ),
                  );
                } else if (state.tanksStatus == TanksStatus.error) {
                  return const Center(
                    child: Text(
                      'No se encontraron tanques para este centro de venta.',
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                final items = state.list;
                TanksEntity? item;
                if (state.selected != const TanksEntity.empty()) {
                  item = state.selected;
                }
                return Column(
                  children: [
                    DropdownTanks<TanksEntity>(
                      controller: controllerDropdown,
                      validator: (p0) {
                        if (p0 == null) {
                          return 'Valor requerido';
                        }
                        return null;
                      },
                      label: 'Tanques',
                      hint: 'Tanques',
                      value: item,
                      showDecoration: false,
                      isLabelTitle: true,
                      items: items,
                      onChanged: (value) {
                        cubitTank.changeSelected(value.value!);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DatePickerHome(
                      title: 'Fecha inicio',
                      value: dashBoardCubit.state.dateInit,
                      label: 'Seleccione fecha',
                      hint: 'Seleccione una fecha',
                      controller: controllerDateInicial,
                      validator: (value) {
                        if (value == null) {
                          return 'Debe seleccionar una fecha';
                        }

                        return null;
                      },
                      isLabelTitle: false,
                      showDecoration: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DatePickerHome(
                      title: 'Fecha final',
                      value: dashBoardCubit.state.dateFinal,
                      label: 'Seleccione fecha',
                      hint: 'Seleccione una fecha',
                      controller: controllerDateFinal,
                      validator: (value) {
                        if (value == null) {
                          return 'Debe seleccionar una fecha';
                        }

                        return null;
                      },
                      isLabelTitle: false,
                      showDecoration: true,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            //side: const BorderSide(color: Colors.grey, width: 2),
            shape: const RoundedRectangleBorder(),
            //backgroundColor: Colors.grey[300],
          ),
          child: const Text('Cerrar'),
        ),
        TextButton(
          onPressed: () {
            final valueTank = cubitTank.state.selected;
            final saleCenter = saleCenterCubit.state.selected;
            if (valueTank.id != 0) {
              Navigator.of(context).pop(true);
              dashBoardCubit.changeDates(
                dateInit: controllerDateInicial.getValue(),
                dateFinal: controllerDateFinal.getValue(),
              );
              dashBoardCubit.getToSaleCenter();

              tankVariationCubit.getToSaleCenterTankDate(
                idCentroVenta: saleCenter.idCentroVenta,
                idTanque: valueTank.id,
                dateInit: controllerDateInicial.getValue(),
                dateFinal: controllerDateFinal.getValue(),
              );
              capacityCubit.getToTank(valueTank.id);
            }
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(
              color: BlueStoneColors.blueStone700,
              width: 2,
            ), // Borde azul
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),

            backgroundColor: BlueStoneColors.blueStone700,
          ),
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}
