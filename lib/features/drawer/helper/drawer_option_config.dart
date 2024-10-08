import 'package:flutter/material.dart';
import 'package:tanks_app/features/article/list/views/article_list.dart';
import 'package:tanks_app/features/binnacle/list/views/binnacle_list_page.dart';
import 'package:tanks_app/features/config/list/views/config_list_body.dart';
import 'package:tanks_app/features/console/list/views/console_list.dart';
import 'package:tanks_app/features/drawer/helper/drawer_option.dart';
import 'package:tanks_app/features/sales_center/list/views/sales_center_list.dart';
import 'package:tanks_app/features/tank_variation/list/views/tank_variation_list.dart';
import 'package:tanks_app/features/tanks/list/views/tanks_list.dart';

enum OptionType {
  order,
  loyaltyProgram,
  registerConsignment,
  registerExpense,
  createClient,
  createArticle,
  intercardQuery,
  sincronizatioQuery,
  paymentDeposit,
  inventory,
  cashClosing,
  configuration,
  sync,
  syncSale,
  logs,
  about,
}

class OptionsConfig {
  // Lista de opciones estática
  static final List<Option> options = [
    const Option(
      type: OptionType.order,
      name: 'Articulos',
      route: ArticleList(),
      icon: Icons.edit_note_outlined,
      askShift: true,
      typeOperation: TypeOperation.normal,
      isActive: true,
      isPermission: true,
    ),
    const Option(
      type: OptionType.loyaltyProgram,
      name: 'Centros de venta',
      route: SalesCenterListPage(),
      typeOperation: TypeOperation.normal,
      icon: Icons.handshake,
      askShift: true,
      isActive: true,
      isPermission: true,
    ),
    const Option(
      type: OptionType.loyaltyProgram,
      name: 'Consolas',
      route: ConsoleListPage(),
      typeOperation: TypeOperation.normal,
      icon: Icons.handshake,
      askShift: true,
      isActive: true,
      isPermission: true,
    ),
    const Option(
      type: OptionType.sincronizatioQuery,
      name: 'Tanques',
      route: TanksListPage(),
      typeOperation: TypeOperation.normal,
      icon: Icons.handshake,
      askShift: true,
      isActive: true,
      isPermission: true,
    ),
    const Option(
      type: OptionType.syncSale,
      name: 'Variacion Tanque',
      route: TankVariationListPage(),
      typeOperation: TypeOperation.normal,
      icon: Icons.handshake,
      askShift: true,
      isActive: true,
      isPermission: true,
    ),
    const Option(
      type: OptionType.configuration,
      name: 'Configuración',
      route: ConfigListPage(),
      typeOperation: TypeOperation.normal,
      icon: Icons.handshake,
      askShift: true,
      isActive: true,
      isPermission: true,
    ),
    const Option(
      type: OptionType.configuration,
      name: 'Bitacora',
      route: BinnacleListPage(),
      typeOperation: TypeOperation.normal,
      icon: Icons.handshake,
      askShift: true,
      isActive: true,
      isPermission: true,
    ),
  ];

  static void toggleOptionActive(OptionType type) {
    final index = options.indexWhere((option) => option.type == type);
    if (index != -1) {
      options[index] =
          options[index].copyWith(isActive: !options[index].isActive);
    }
  }
}
