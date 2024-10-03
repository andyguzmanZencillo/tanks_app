import 'package:flutter/material.dart';

class FormCapacityInherited extends InheritedWidget {
  FormCapacityInherited({
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  final Map<int, TextEditingController> mapAlturaTanque = {};
  final Map<int, TextEditingController> mapVolumen = {};
  final formKey = GlobalKey<FormState>();
  final Map<int, FocusNode> mapFocusNode = {};

  static FormCapacityInherited of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<FormCapacityInherited>();
    assert(result != null, 'No LicenseFormInherited found in context');
    return result!;
  }

  TextEditingController getOrCreateAlturaTanque(int id) {
    if (!mapAlturaTanque.containsKey(id)) {
      mapAlturaTanque[id] = TextEditingController();
    }
    return mapAlturaTanque[id]!;
  }

  TextEditingController getOrCreateVolumen(int id) {
    if (!mapVolumen.containsKey(id)) {
      mapVolumen[id] = TextEditingController();
    }
    return mapVolumen[id]!;
  }

  FocusNode getOrCreateFocusNode(int id) {
    if (!mapFocusNode.containsKey(id)) {
      mapFocusNode[id] = FocusNode();
    }
    return mapFocusNode[id]!;
  }

  List<ResultField> getValuesAlturaTanque() {
    return mapAlturaTanque.entries
        .map((entry) => ResultField(id: entry.key, value: entry.value.text))
        .toList();
  }

  List<ResultField> getValuesVolumen() {
    return mapVolumen.entries
        .map((entry) => ResultField(id: entry.key, value: entry.value.text))
        .toList();
  }

  void dispose() {
    mapAlturaTanque.forEach((key, value) {
      value.dispose();
    });

    mapVolumen.forEach((key, value) {
      value.dispose();
    });
    mapFocusNode.forEach((key, value) {
      value.dispose();
    });
  }

  bool valid() {
    return formKey.currentState!.validate();
  }
}

class ResultField {
  ResultField({required this.id, required this.value});

  final int id;
  final String value;
}
