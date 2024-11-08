import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/extensions/extension_date.dart';
import 'package:tanks_app/core/util/extensions/extension_double.dart';
import 'package:tanks_app/core/util/extensions/extension_string.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/core/widgets/button/custom_elevate_button.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/features/capacity_table/list/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/sales_center/delete/helpers/sales_center_delete_listener.dart';
import 'package:tanks_app/features/tank_variation/create_update/cubit/upsert_tank_variation_cubit.dart';
import 'package:tanks_app/features/tank_variation/create_update/helper/controller_to_entity.dart';
import 'package:tanks_app/features/tank_variation/create_update/helper/upsert_tank_variation_inherited.dart';
import 'package:tanks_app/features/tank_variation/create_update/widgets/field.dart';
import 'package:tanks_app/features/tank_variation/list/cubit/tank_variation_cubit.dart';

class UpsertTankVariationBody extends StatelessWidget {
  const UpsertTankVariationBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = UpsertTankVariationInherited.of(context);
    final capacitys = context.watch<CapacityTableCubit>();

    final tankVariationCubit = context.read<TankVariationCubit>();

    return BlocContext<UpsertTankVariationCubit, UpsertTankVariationState>(
      builder: (context, cubit) {
        var active = inherited.saldoFinal.getValue().isNullOrZero();
        if (tankVariationCubit.state.dateSearch!.equal(DateTime.now())) {
          active = true;
        }

        final activeConsola =
            !(tankVariationCubit.state.selectedPro.tank.idConsolaTanque != 0);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Variación de tanque',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!activeConsola)
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: BlueStoneColors.blueStone200,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Text(
                              'Tanque modo Consola ',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 204, 204, 204),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Text(
                              'Tanque modo Manual',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (!active)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 228, 117, 109),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Text(
                              'Variación cerrada',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  body(
                    active: activeConsola,
                    title: 'Inicial',
                    icon: const Icon(FluentIcons.arrow_circle_right_24_regular),
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.saldoFinalAnterior,
                              label: 'Saldo Fin. Ant.',
                              enable: false,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.aguanFinalAnterior,
                              label: 'Agua Fin. Ant.',
                              enable: false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.altura,
                              label: 'Altura',
                              enable: capacitys.state.status ==
                                      GeneralStatus.success &&
                                  active,
                              onFocusChange: (focus, value) {
                                if (!focus) {
                                  final aforos = capacitys.aforos;
                                  final volumen = cubit.searchAforo(
                                    capacityEntitys: aforos,
                                    rValorBuscado: value.toDoubleSafe(),
                                  );
                                  if (volumen != 0) {
                                    inherited.saldoInicial.setValue(
                                      volumen.toString(),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FieldVariationTank(
                              controller: ControllerField(),
                              label: 'Altura Agua',
                              enable: capacitys.state.status ==
                                      GeneralStatus.success &&
                                  active,
                              onFocusChange: (focus, value) {
                                if (!focus) {
                                  final aforos = capacitys.aforos;
                                  final volumen = cubit.searchAforo(
                                    capacityEntitys: aforos,
                                    rValorBuscado: value.toDoubleSafe(),
                                  );
                                  if (volumen != 0) {
                                    inherited.aguaInicial.setValue(
                                      volumen.toString(),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.saldoInicial,
                              label: 'Saldo inicial',
                              enable: active,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.aguaInicial,
                              label: 'Agua inicial',
                              enable: active,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  body(
                    title: 'Compra',
                    icon: const Icon(Icons.currency_exchange),
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.compra,
                              label: 'Compra',
                              enable: active,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.costoPorGin,
                              label: 'Costo por Gal.',
                              enable: active,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FieldVariationTank(
                        controller: inherited.factura,
                        label: 'Factura',
                        enable: active,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  body(
                    active: activeConsola,
                    title: 'Descargue',
                    icon: const Icon(FluentIcons.production_20_regular),
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.medidaInicial,
                              label: 'Medida inicial',
                              enable: capacitys.state.status ==
                                      GeneralStatus.success &&
                                  active,
                              onFocusChange: (focus, value) {
                                if (!focus) {
                                  final aforos = capacitys.aforos;
                                  final volumen = cubit.searchAforo(
                                    capacityEntitys: aforos,
                                    rValorBuscado: value.toDoubleSafe(),
                                  );
                                  if (volumen != 0) {
                                    inherited.saldoInicialVol.setValue(
                                      volumen.toString(),
                                    );
                                    final saldoInicialVol = inherited
                                        .saldoInicialVol
                                        .getValue()
                                        .toDoubleSafe();
                                    final saldoFinalVol = inherited
                                        .saldoFinalVol
                                        .getValue()
                                        .toDoubleSafe();

                                    final descargue =
                                        saldoInicialVol - saldoFinalVol;
                                    inherited.descargue.setValue(
                                      descargue.toString(),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.medidaFinal,
                              label: 'Medida final',
                              enable: capacitys.state.status ==
                                      GeneralStatus.success &&
                                  active,
                              onFocusChange: (focus, value) {
                                if (!focus) {
                                  final aforos = capacitys.aforos;
                                  final volumen = cubit.searchAforo(
                                    capacityEntitys: aforos,
                                    rValorBuscado: value.toDoubleSafe(),
                                  );
                                  if (volumen != 0) {
                                    inherited.saldoFinalVol.setValue(
                                      volumen.toString(),
                                    );

                                    final saldoInicialVol = inherited
                                        .saldoInicialVol
                                        .getValue()
                                        .toDoubleSafe();
                                    final saldoFinalVol = inherited
                                        .saldoFinalVol
                                        .getValue()
                                        .toDoubleSafe();

                                    final descargue =
                                        saldoInicialVol - saldoFinalVol;
                                    inherited.descargue.setValue(
                                      descargue.toString(),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.saldoInicialVol,
                              label: 'Saldo inicial(Vol)',
                              enable: active,
                              onFocusChange: (p0, p1) {
                                final saldoInicialVol = inherited
                                    .saldoInicialVol
                                    .getValue()
                                    .toDoubleSafe();
                                final saldoFinalVol = inherited.saldoFinalVol
                                    .getValue()
                                    .toDoubleSafe();

                                final descargue =
                                    saldoFinalVol - saldoInicialVol;
                                inherited.descargue.setValue(
                                  descargue.toString(),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.saldoFinalVol,
                              label: 'Saldo final(Vol)',
                              enable: active,
                              onFocusChange: (p0, p1) {
                                final saldoInicialVol = inherited
                                    .saldoInicialVol
                                    .getValue()
                                    .toDoubleSafe();
                                final saldoFinalVol = inherited.saldoFinalVol
                                    .getValue()
                                    .toDoubleSafe();

                                final descargue =
                                    saldoFinalVol - saldoInicialVol;
                                inherited.descargue.setValue(
                                  descargue.toString(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: SizedBox(),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Stack(
                              children: [
                                FieldVariationTank(
                                  controller: inherited.descargue,
                                  label: 'Descargue',
                                  enable: active,
                                  onChanged: (value) {
                                    inherited.medidaInicial.setValue('');
                                    inherited.medidaFinal.setValue('');
                                    inherited.saldoInicialVol.setValue('');
                                    inherited.saldoFinalVol.setValue('');
                                  },
                                  //enable: false,
                                ),
                                const SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  body(
                    active: activeConsola,
                    title: 'Final',
                    icon: const Icon(FluentIcons.arrow_circle_left_24_regular),
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.alturaFinal,
                              label: 'Altura final',
                              enable: capacitys.state.status ==
                                      GeneralStatus.success &&
                                  active,
                              onFocusChange: (focus, value) {
                                if (!focus) {
                                  final aforos = capacitys.aforos;
                                  final volumen = cubit.searchAforo(
                                    capacityEntitys: aforos,
                                    rValorBuscado: value.toDoubleSafe(),
                                  );
                                  if (volumen != 0) {
                                    inherited.saldoFinal.setValue(
                                      volumen.toString(),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.alturaAgua,
                              label: 'Altura agua',
                              enable: capacitys.state.status ==
                                      GeneralStatus.success &&
                                  active,
                              onFocusChange: (focus, value) {
                                if (!focus) {
                                  final aforos = capacitys.aforos;
                                  final volumen = cubit.searchAforo(
                                    capacityEntitys: aforos,
                                    rValorBuscado: value.toDoubleSafe(),
                                  );
                                  if (volumen != 0) {
                                    inherited.aguaFinal.setValue(
                                      volumen.toString(),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.saldoFinal,
                              label: 'Saldo final',
                              enable: active,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.aguaFinal,
                              enable: active,
                              label: 'Agua final',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (active)
                    ButtonCustom(
                      onPressed: () {
                        if (!activeConsola) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          cubit.create(
                            tankVariationEntity:
                                inherited.toTankVariationEntity(
                              tankVariationCubit
                                  .state.selectedPro.tank.idTanque,
                              tankVariationCubit.state.dateSearch ??
                                  DateTime.now(),
                            ),
                          );
                        } else if (inherited.saldoInicial
                                .getValue()
                                .isNullOrZero() &&
                            inherited.aguaInicial.getValue().isNullOrZero()) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          _showExitConfirmationDialog(context, () {
                            cubit.create(
                              tankVariationEntity:
                                  inherited.toTankVariationEntity(
                                tankVariationCubit
                                    .state.selectedPro.tank.idTanque,
                                tankVariationCubit.state.dateSearch ??
                                    DateTime.now(),
                              ),
                            );
                          });
                        } else {
                          FocusManager.instance.primaryFocus?.unfocus();
                          cubit.create(
                            tankVariationEntity:
                                inherited.toTankVariationEntity(
                              tankVariationCubit
                                  .state.selectedPro.tank.idTanque,
                              tankVariationCubit.state.dateSearch ??
                                  DateTime.now(),
                            ),
                          );
                        }
                      },
                      text: 'Registrar variación',
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showExitConfirmationDialog(
    BuildContext context,
    void Function() onPressed,
  ) async {
    return context.show(
      AlertDialog(
        title: const Text('Confirmar registro'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '¿Estás seguro de que deseas realizar el registro con el saldo inicial en cero y agua inicial en cero?',
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ButtonCustom(
                    backgroundColor: Colors.grey,
                    onPressed: () {
                      context.pop();
                    },
                    text: 'Cancelar',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomElevateButton(
                    onPressed: () {
                      context.pop();
                      onPressed.call();
                    },
                    text: 'Registrar',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget body({
    required List<Widget> children,
    required String title,
    required Icon icon,
    bool active = true,
  }) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  icon,
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ...children,
            ],
          ),
        ),
        if (!active)
          Positioned.fill(
            child: ColoredBox(
              color: const Color.fromARGB(255, 223, 223, 223).withOpacity(0.5),
            ),
          ),
      ],
    );
  }
}
