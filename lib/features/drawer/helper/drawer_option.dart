import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tanks_app/features/drawer/helper/drawer_option_config.dart';

enum TypeOperation { normal, sincronization, sincronizactionsale, about }

class Option extends Equatable {
  const Option({
    required this.type,
    required this.name,
    required this.icon,
    this.route,
  });
  final OptionType type;
  final String name;
  final Widget? route;
  final IconData icon;

  Option copyWith({
    OptionType? type,
    String? name,
    Widget? route,
    IconData? icon,
    bool? askShift,
    bool? isActive,
    TypeOperation? typeOperation,
    bool? isPermission,
  }) {
    return Option(
      type: type ?? this.type,
      name: name ?? this.name,
      route: route ?? this.route,
      icon: icon ?? this.icon,
    );
  }

  @override
  List<Object?> get props => [
        type,
        name,
        route,
        icon,
      ];
}
