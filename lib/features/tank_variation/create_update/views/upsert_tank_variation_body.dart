import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/util/extensions/extension_string.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/field_custom.dart';
import 'package:tanks_app/features/capacity_table/list/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/tank_variation/create_update/cubit/upsert_tank_variation_cubit.dart';
import 'package:tanks_app/features/tank_variation/create_update/helper/controller_to_entity.dart';
import 'package:tanks_app/features/tank_variation/create_update/helper/upsert_tank_variation_inherited.dart';
import 'package:tanks_app/features/tank_variation/create_update/widgets/field.dart';

class UpsertTankVariationBody extends StatelessWidget {
  const UpsertTankVariationBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = UpsertTankVariationInherited.of(context);
    final capacitys = context.read<CapacityTableCubit>();

    Widget body({
      required List<Widget> children,
      required String title,
      required Icon icon,
    }) {
      return Container(
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
      );
    }

    return BlocContext<UpsertTankVariationCubit, UpsertTankVariationState>(
      builder: (context, cubit) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 238, 238, 238),
          appBar: AppBar(
            title: const Text('Variación de tanque'),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 238, 238, 238),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  body(
                    title: 'Inicial',
                    icon: const Icon(FluentIcons.arrow_circle_right_24_regular),
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.saldoFinalAnterior,
                              label: 'Saldo Fin. Ant.',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.aguanFinalAnterior,
                              label: 'Agua Fin. Ant.',
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
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.aguaInicial,
                              label: 'Agua inicial',
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
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.costoPorGin,
                              label: 'Costo por Gin.',
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  body(
                    title: 'Descargue',
                    icon: const Icon(FluentIcons.production_20_regular),
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.medidaInicial,
                              label: 'Medida inicial',
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
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.saldoFinalVol,
                              label: 'Saldo final(Vol)',
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
                                  enable: false,
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
                    title: 'Final',
                    icon: const Icon(FluentIcons.arrow_circle_left_24_regular),
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.alturaFinal,
                              label: 'Altura final',
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
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FieldVariationTank(
                              controller: inherited.aguaFinal,
                              label: 'Agua final',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ButtonCustom(
                    onPressed: () {
                      cubit.create(
                        tankVariationEntity: inherited.toTankVariationEntity(),
                      );
                      FocusManager.instance.primaryFocus?.unfocus();
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
}
