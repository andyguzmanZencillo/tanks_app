/*import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UpsertCapacityTableInherited extends InheritedWidget {
  UpsertCapacityTableInherited({
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  final Map<String, ResultText> mapCapacity = {};
  final Map<int, TextEditingController> mapVolumen = {};
  final formKey = GlobalKey<FormState>();
  final Map<int, FocusNode> mapFocusNode = {};

  static UpsertCapacityTableInherited of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<UpsertCapacityTableInherited>();
    assert(result != null, 'No LicenseFormInherited found in context');
    return result!;
  }

  ResultText getOrCreateCapacity(String id) {
    if (!mapCapacity.containsKey(id)) {
      mapCapacity[id] = ResultText(
        altura: TextEditingController(),
        volumen: TextEditingController(),
      );
    }
    return mapCapacity[id]!;
  }

  FocusNode getOrCreateFocusNode(int id) {
    if (!mapFocusNode.containsKey(id)) {
      mapFocusNode[id] = FocusNode();
    }
    return mapFocusNode[id]!;
  }

  List<ResultField> getValues() {
    return mapCapacity.entries
        .map(
          (entry) => ResultField(
            id: entry.key,
            altura: entry.value.altura.text,
            volumen: entry.value.volumen.text,
          ),
        )
        .toList();
  }

  void dispose() {
    mapCapacity.forEach((key, value) {
      value.altura.dispose();
      value.volumen.dispose();
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
  ResultField({
    required this.id,
    required this.altura,
    required this.volumen,
  });

  final String id;
  final String altura;
  final String volumen;
}

class ResultText {
  ResultText({required this.altura, required this.volumen});

  final TextEditingController altura;
  final TextEditingController volumen;
}
*/