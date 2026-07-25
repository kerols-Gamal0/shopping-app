import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'base_state.dart';

class BaseStateBuilder<T> extends StatelessWidget {
  final BaseState<T> state;
  final Widget Function(T data) onSuccess;
  final Widget Function(String error)? onFailure;
  final Widget? onLoading;
  final Widget? onInitial;

  const BaseStateBuilder({
    super.key,
    required this.state,
    required this.onSuccess,
    this.onFailure,
    this.onLoading,
    this.onInitial,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return switch (state) {
      BaseInitialState() => onInitial ?? const SizedBox.shrink(),

      BaseLoadingState() =>
        onLoading ??
            GridView.builder(
              padding: const EdgeInsets.all(16),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.62,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: theme.colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.6),
                  highlightColor: theme.colorScheme.surface,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                );
              },
            ),

      BaseFailureState(errorMessage: final msg) =>
        onFailure != null
            ? onFailure!(msg)
            : Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.x2),
                  child: Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ),

      BaseSuccessState(data: final data) => onSuccess(data),
    };
  }
}
