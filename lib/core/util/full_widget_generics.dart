import 'package:flutter/material.dart';

class FullWidgetGeneric extends StatefulWidget {
  const FullWidgetGeneric({
    required this.child,
    required this.onInit,
    required this.onDispose,
    super.key,
  });

  final Widget child;
  final void Function() onInit;
  final void Function() onDispose;

  @override
  State<FullWidgetGeneric> createState() => _FullWidgetGenericState();
}

class _FullWidgetGenericState extends State<FullWidgetGeneric> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
