import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ContextRouter on BuildContext {
  void go(Route<void> route) {
    Navigator.pushReplacement(this, route);
  }

  void push(Route<void> route) {
    Navigator.push(this, route);
  }

  Future<T?> pushResult<T>(Route<T> route) {
    return Navigator.push<T>(this, route);
  }

  Future<T?> pushCompleteWithProvider<T>({
    required Widget page,
    required List<BlocProvider> blocProviders,
  }) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute<T>(
        builder: (_) => MultiBlocProvider(
          providers: blocProviders,
          child: page,
        ),
      ),
    );
  }

  Future<T?> pushCompleteWithSingleProvider<T>({
    required Widget page,
    required BlocProvider blocProvider,
  }) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute<T>(
        builder: (_) => MultiBlocProvider(
          providers: [blocProvider],
          child: page,
        ),
      ),
    );
  }

  Future<T?> pushCompleteWithBloc<T>({
    required Widget page,
    // ignore: strict_raw_type
    required List<BlocBase> blocs,
  }) {
    // Convertir cada Bloc en BlocProvider usando BlocProvider.value
    final blocProviders =
        blocs.map((bloc) => BlocProvider.value(value: bloc)).toList();

    return Navigator.push<T>(
      this,
      MaterialPageRoute<T>(
        builder: (_) => MultiBlocProvider(
          providers: blocProviders,
          child: page,
        ),
      ),
    );
  }

  void pushContext(Widget child) {
    Navigator.push(
      this,
      MaterialPageRoute<void>(
        builder: (context) => child,
      ),
    );
  }

  void goComplete(
    Widget page,
  ) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute<void>(
        builder: (_) => page,
      ),
    );
  }

  void pushComplete(
    Widget page,
  ) {
    Navigator.push(
      this,
      MaterialPageRoute<void>(
        builder: (_) => page,
      ),
    );
  }

  void pop() {
    Navigator.pop(this);
  }

  void popHome() {
    Navigator.popUntil(this, (route) => route.isFirst);
  }
}
