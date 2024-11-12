import 'package:flutter/material.dart';
import 'package:tanks_app/features/article/views/article_list_page.dart';
import 'package:tanks_app/features/binnacle/list/views/binnacle_list_page.dart';
import 'package:tanks_app/features/config/views/config_list_page.dart';
import 'package:tanks_app/features/console/views/console_list.dart';
import 'package:tanks_app/features/drawer/helper/drawer_option.dart';
import 'package:tanks_app/features/profile/information_profile/views/information_profile_view.dart';
import 'package:tanks_app/features/sales_center/views/sales_center_list.dart';
import 'package:tanks_app/features/tank_variation/list/views/tank_variation_list.dart';
import 'package:tanks_app/features/tanks/views/tanks_list.dart';

enum OptionType {
  article,
  salecenter,
  console,
  tank,
  tankvariation,
  config,
  bitacora,
  notification,
}

class OptionsConfig {
  // Lista de opciones estática
  static final List<Option> options = [
    const Option(
      type: OptionType.article,
      name: 'Perfil',
      route: InformationProfilePage(),
      icon: Icons.person, // Ícono de inventario para artículos
    ),
    const Option(
      type: OptionType.article,
      name: 'Artículos',
      route: ArticleListPage(),
      icon: Icons.inventory_2, // Ícono de inventario para artículos
    ),
    const Option(
      type: OptionType.salecenter,
      name: 'Centros de venta',
      route: SalesCenterListPage(),
      icon: Icons.store, // Ícono de tienda para centros de venta
    ),
    const Option(
      type: OptionType.console,
      name: 'Consolas',
      route: ConsoleListPage(),
      icon: Icons.dashboard, // Ícono de consola de videojuegos para consolas
    ),
    const Option(
      type: OptionType.tank,
      name: 'Tanques',
      route: TanksListPage(),
      icon: Icons.oil_barrel, // Ícono de barril de aceite para tanques
    ),
    const Option(
      type: OptionType.tankvariation,
      name: 'Variación Tanque',
      route: TankVariationListPage(),
      icon: Icons
          .compare_arrows, // Ícono de flechas cruzadas para variación de tanques
    ),
    const Option(
      type: OptionType.config,
      name: 'Configuración',
      route: ConfigListPage(),
      icon: Icons.settings, // Ícono de configuración
    ),
    const Option(
      type: OptionType.bitacora,
      name: 'Bitácora',
      route: BinnacleListPage(),
      icon: Icons.book, // Ícono de libro para bitácora
    ),
  ];
}
