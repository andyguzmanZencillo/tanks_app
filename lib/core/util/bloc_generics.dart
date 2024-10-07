import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitWithCubitBuilder<C extends Cubit<S>, S> extends StatelessWidget {
  const CubitWithCubitBuilder({
    required this.builder,
    super.key,
  });
  final Widget Function(BuildContext context, S state, C cubit) builder;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<C>(); // Obtén el Cubit aquí

    return BlocBuilder<C, S>(
      builder: (context, state) {
        return builder(context, state, cubit);
      },
    );
  }
}

class BlocWithSelector<B extends BlocBase<S>, S, T> extends StatelessWidget {
  const BlocWithSelector({
    required this.selector,
    required this.builder,
    super.key,
  });
  final T Function(S state) selector;
  final Widget Function(BuildContext context, T selectedState, B bloc) builder;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<B>();

    return BlocSelector<B, S, T>(
      selector: selector,
      builder: (context, selectedState) {
        return builder(context, selectedState, bloc);
      },
    );
  }
}

class BlocWithBuilder<B extends BlocBase<S>, S> extends StatelessWidget {
  const BlocWithBuilder({
    required this.builder,
    super.key,
  });
  final Widget Function(BuildContext context, S state, B bloc) builder;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<B>();

    return BlocBuilder<B, S>(
      builder: (context, state) {
        return builder(context, state, bloc);
      },
    );
  }
}

class BlocContext<B extends BlocBase<S>, S> extends StatelessWidget {
  const BlocContext({
    required this.builder,
    super.key,
  });
  final Widget Function(BuildContext context, B bloc) builder;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<B>();

    return builder(context, bloc);
  }
}

abstract class BaseState {}

class BaseInitial extends BaseState {}

class BaseLoading extends BaseState {}

class BaseSuccess extends BaseState {}

class BaseError extends BaseState {
  BaseError(this.message);
  final String message;
}

abstract class BaseBloc<T extends BaseState> extends Cubit<T> {
  BaseBloc(super.initialState);

  void showLoading() {
    emit(BaseLoading() as T);
  }

  void showError(String message) {
    emit(BaseError(message) as T);
  }

  void showSuccess() {
    emit(BaseSuccess() as T);
  }
}
