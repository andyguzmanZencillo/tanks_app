import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tanks_app/features/drawer/helper/drawer_option_config.dart';

enum TypeOperation { normal, sincronization, sincronizactionsale, about }

class Option extends Equatable {
  const Option({
    required this.type,
    required this.name,
    required this.icon,
    required this.askShift,
    required this.isActive,
    required this.typeOperation,
    required this.isPermission,
    this.route,
  });
  final OptionType type;
  final String name;
  final Widget? route;
  final IconData icon;
  final bool askShift;
  final bool isActive;
  final bool isPermission;
  final TypeOperation typeOperation;

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
      askShift: askShift ?? this.askShift,
      isActive: isActive ?? this.isActive,
      typeOperation: typeOperation ?? this.typeOperation,
      isPermission: isPermission ?? this.isPermission,
    );
  }

  @override
  List<Object?> get props => [
        type,
        name,
        route,
        icon,
        askShift,
        isActive,
        isActive,
        typeOperation,
        isPermission,
      ];
}
