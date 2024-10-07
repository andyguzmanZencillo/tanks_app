import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/widgets/field_custom.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';

class UpsertTankVariationInherited extends InheritedWidget {
  UpsertTankVariationInherited({
    required super.child,
    required this.typeOperation,
    this.tankVariationEntity = const TankVariationEntity.empty(),
    super.key,
  }) {
    if (typeOperation == TypeOperation.update) {
      // Aquí se liberan los recursos de los controladores
      saldoFinalAnterior.setValue(
        tankVariationEntity.inventarioFinalFisico.toString(),
      );
      altura.setValue(tankVariationEntity.calibracion.toString());
      saldoInicial.setValue(tankVariationEntity.saldoInicial.toString());

      //---------- Agua
      aguanFinalAnterior.setValue(
        tankVariationEntity.aguaFinal.toString(),
      );
      alturaAgua.setValue(
        tankVariationEntity.inventarioFinalCalculado.toString(),
      );
      aguaInicial.setValue(
        tankVariationEntity.aguaInicial.toString(),
      );

      // COMPRA
      compra.setValue(tankVariationEntity.comprasFacturas.toString());
      factura.setValue(tankVariationEntity.inventarioFinalCalculado.toString());
      costoPorGin.setValue(tankVariationEntity.calibracion.toString());

      // DESCARGUE
      medidaInicial.setValue(tankVariationEntity.variacionTotalPorcentaje);
      saldoInicialVol.setValue(tankVariationEntity.variacionTransitoPorcentaje);

      //----------- Final Descargue
      medidaFinal.setValue(tankVariationEntity.variacionOperacionalPorcentaje);
      saldoFinalVol
          .setValue(tankVariationEntity.variacionOperacionalPorcentaje);
      descargue.setValue(tankVariationEntity.variacionOperacionalPorcentaje);

      // FINAL
      alturaFinal.setValue(tankVariationEntity.variacionOperacionalPorcentaje);
      saldoFinal.setValue(tankVariationEntity.variacionOperacionalPorcentaje);

      //--------- Agua Final
      alturaAguaFinal
          .setValue(tankVariationEntity.variacionOperacionalPorcentaje);
      aguaFinal.setValue(tankVariationEntity.variacionOperacionalPorcentaje);
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  final TypeOperation typeOperation;
  final TankVariationEntity tankVariationEntity;

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
