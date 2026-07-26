import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';

class BaseStateBuilder<T> extends StatelessWidget {
  const BaseStateBuilder({
    super.key,
    required this.state,
    required this.onSuccess,
    required this.onLoading,
    required this.onError,
  });

  final BaseState<T> state;
  final Widget Function(T data) onSuccess;
  final Widget Function() onLoading;
  final Widget Function(String error) onError;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      BaseLoadingState() => onLoading(),
      BaseSuccessState(data: final data) => onSuccess(data),
      BaseFailureState(errorMessage: final message) => onError(message),
    };
  }
}
