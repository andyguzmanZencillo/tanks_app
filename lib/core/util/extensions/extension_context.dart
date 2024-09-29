import 'package:flutter/material.dart';

extension ContextRouter on BuildContext {
  void go(Route<void> route) {
    Navigator.pushReplacement(this, route);
  }

  void push(Route<void> route) {
    Navigator.push(this, route);
  }

  void pop() {
    Navigator.pop(this);
  }

  void popHome() {
    Navigator.popUntil(this, (route) => route.isFirst);
  }
}
