import 'package:flutter/material.dart';

class FullWidgetGeneric extends StatefulWidget {
  const FullWidgetGeneric({
    required this.child,
    this.onInit,
    this.onDispose,
    super.key,
  });

  final Widget child;
  final void Function()? onInit;
  final void Function()? onDispose;

  @override
  State<FullWidgetGeneric> createState() => _FullWidgetGenericState();
}

class _FullWidgetGenericState extends State<FullWidgetGeneric> {
  @override
  void initState() {
    super.initState();
    widget.onInit?.call();
  }

  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
