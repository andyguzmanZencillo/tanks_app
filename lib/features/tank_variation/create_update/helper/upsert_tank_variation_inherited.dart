import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tank_repository/features/tank_variation/entity/tank_variation_entity.dart';
import 'package:tank_repository/features/tank_variation/entity/tank_variation_multi_entity.dart';
import 'package:tanks_app/core/util/extensions/extension_double.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/features/article/helpers/create_update_inherited.dart';

class UpsertTankVariationInherited extends InheritedWidget {
  UpsertTankVariationInherited({
    required super.child,
    required this.typeOperation,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  final TypeOperation typeOperation;

  //INICIAL
  final saldoFinalAnterior = ControllerField();
  final altura = ControllerField();
  final saldoInicial = ControllerField();
  //----------
  final aguanFinalAnterior = ControllerField();
  final alturaAgua = ControllerField();
  final aguaInicial = ControllerField();

  //COMPRA
  final compra = ControllerField();
  final factura = ControllerField();
  final costoPorGin = ControllerField();

  //DESCARGUE
  final medidaInicial = ControllerField();
  final saldoInicialVol = ControllerField();
  //-----------
  final medidaFinal = ControllerField();
  final saldoFinalVol = ControllerField();
  final descargue = ControllerField();

  //FINAL
  final alturaFinal = ControllerField();
  final saldoFinal = ControllerField();
  //---------
  final alturaAguaFinal = ControllerField();
  final aguaFinal = ControllerField();

  final formKey = GlobalKey<FormState>();

  static UpsertTankVariationInherited of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<UpsertTankVariationInherited>();
    assert(result != null, 'No UpsertConsoleInherited found in context');
    return result!;
  }

  void setData(TankVariationMultiEntity tankVariationMultEntity) {
    final tankVariationEntity =
        tankVariationMultEntity.tankVariation.firstOrNull ??
            const TankVariationEntity.empty();
    final tankVariationLastEntity =
        tankVariationMultEntity.tanksVariationLast.firstOrNull ??
            const TankVariationLastEntity.empty();

    saldoFinalAnterior.setValue(
      tankVariationLastEntity.saldoFinal.toSafeString(),
    );
    altura.setValue(
      '',
    );
    saldoInicial.setValue(
      tankVariationEntity.saldoInicial.toString(),
    );

    aguanFinalAnterior.setValue(
      tankVariationLastEntity.aguaFinal.toSafeString(),
    );
    alturaAgua.setValue(
      '',
    );
    aguaInicial.setValue(
      tankVariationEntity.aguaInicial.toString(),
    );

    // COMPRA
    compra.setValue(tankVariationEntity.comprasFacturas.toString());
    factura.setValue(tankVariationEntity.inventarioFinalCalculado.toString());
    costoPorGin.setValue(tankVariationEntity.calibracion.toString());

    // DESCARGUE
    medidaInicial.setValue('');
    saldoInicialVol.setValue('');

    //----------- Final Descargue
    medidaFinal.setValue('');
    saldoFinalVol.setValue('');
    descargue.setValue(tankVariationEntity.descargue.toString());

    // FINAL
    alturaFinal.setValue('');
    saldoFinal.setValue(tankVariationEntity.saldoFinal.toString());

    //--------- Agua Final
    alturaAguaFinal.setValue('');
    aguaFinal.setValue(tankVariationEntity.aguaFinal.toString());
  }

  void setDataLast() {
    if (saldoInicial.getValue().isNullOrZero() &&
        saldoFinal.getValue().isNullOrZero() &&
        aguaInicial.getValue().isNullOrZero() &&
        aguaFinal.getValue().isNullOrZero()) {
      saldoInicial.setValue(
        saldoFinalAnterior.getValue(),
      );
      aguaInicial.setValue(
        aguanFinalAnterior.getValue(),
      );
    }
  }

  void dispose() {
    // Aquí se liberan los recursos de los controladores
    saldoFinalAnterior.dispose();
    altura.dispose();
    saldoInicial.dispose();

    //---------- Agua
    aguanFinalAnterior.dispose();
    alturaAgua.dispose();
    aguaInicial.dispose();

    // COMPRA
    compra.dispose();
    factura.dispose();
    costoPorGin.dispose();

    // DESCARGUE
    medidaInicial.dispose();
    saldoInicialVol.dispose();

    //----------- Final Descargue
    medidaFinal.dispose();
    saldoFinalVol.dispose();
    descargue.dispose();

    // FINAL
    alturaFinal.dispose();
    saldoFinal.dispose();

    //--------- Agua Final
    alturaAguaFinal.dispose();
    aguaFinal.dispose();
  }

  ResultValidate valid() {
    return formKey.validateAndGetErrors([
      saldoFinalAnterior.fieldKey, // Saldo Final Anterior
      altura.fieldKey, // Altura
      saldoInicial.fieldKey, // Saldo Inicial
      aguanFinalAnterior.fieldKey, // Agua Final Anterior
      alturaAgua.fieldKey, // Altura Agua
      aguaInicial.fieldKey, // Agua Inicial
      compra.fieldKey, // Compra
      factura.fieldKey, // Factura
      costoPorGin.fieldKey, // Costo por Gin
      medidaInicial.fieldKey, // Medida Inicial
      saldoInicialVol.fieldKey, // Saldo Inicial Vol
      medidaFinal.fieldKey, // Medida Final
      saldoFinalVol.fieldKey, // Saldo Final Vol
      descargue.fieldKey, // Descargue
      alturaFinal.fieldKey, // Altura Final
      saldoFinal.fieldKey, // Saldo Final
      alturaAguaFinal.fieldKey, // Altura Agua Final
      aguaFinal.fieldKey, // Agua Final
    ]);
  }
}
