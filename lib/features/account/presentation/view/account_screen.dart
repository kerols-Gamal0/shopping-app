import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/common/base_state/base_state_builder.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/theme/account_theme_colors.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/features/account/domain/entities/user_entity.dart';
import 'package:shopping_app/features/account/presentation/view/widgets/custom_text_form_field.dart';
import 'package:shopping_app/features/account/presentation/view/widgets/profile_image_widget.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_cubit.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final accountColors = theme.extension<AccountThemeColors>()!;

    return BlocProvider(
      create: (context) =>
          serviceLocator<AccountCubit>()..doIntent(GetUserDataIntent()),
      child: Scaffold(
        backgroundColor: accountColors.screenBackground,
        appBar: AppBar(
          title: Text(
            AppStrings.accountTitle,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BlocConsumer<AccountCubit, AccountState>(
          listener: (context, state) {
            if (state is AccountDataState) {
              if (state.state is BaseSuccessState<UserEntity?>) {
                _showSuccessSnackBar(context, AppStrings.accountSuccessMessage);
              } else if (state.state is BaseFailureState) {
                final errorMsg = (state.state as BaseFailureState).errorMessage;
                _showErrorSnackBar(context, errorMsg);
              }
            }
          },
          builder: (context, state) {
            final cubit = context.read<AccountCubit>();

            BaseState<UserEntity?> currentBaseState;
            if (state is AccountDataState) {
              currentBaseState = state.state;
            } else {
              currentBaseState = BaseSuccessState(data: cubit.userEntity);
            }

            return BaseStateBuilder<UserEntity?>(
              state: currentBaseState,
              onLoading: () => Center(
                child: CircularProgressIndicator(color: colorScheme.primary),
              ),
              onError: (error) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 60,
                        color: colorScheme.error,
                      ),
                      verticalSpace(AppSpacing.x2),
                      Text(
                        error,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                      verticalSpace(AppSpacing.x2),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => cubit.doIntent(GetUserDataIntent()),
                        child: Text(
                          AppStrings.accountTryAgain,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onSuccess: (data) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        verticalSpace(AppSpacing.x1),
                        ProfileImageWidget(cubit: cubit, userEntity: data),
                        verticalSpace(35),
                        CustomTextFormField(
                          controller: cubit.nameController,
                          label: AppStrings.accountName,
                          icon: Icons.person_outline,
                        ),
                        verticalSpace(AppSpacing.x2),
                        CustomTextFormField(
                          controller: cubit.emailController,
                          label: AppStrings.accountEmail,
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        verticalSpace(AppSpacing.x2),
                        CustomTextFormField(
                          controller: cubit.phoneController,
                          label: AppStrings.accountPhone,
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: cubit.addressController,
                          label: AppStrings.accountAddress,
                          icon: Icons.location_on_outlined,
                        ),
                        verticalSpace(AppSpacing.x4),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () =>
                                cubit.doIntent(EditUserDataIntent()),
                            child: Text(
                              AppStrings.accountSubmit,
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(AppSpacing.x2),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.background),
            const SizedBox(width: 10),
            Expanded(
              child: Text(message, style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String errorMsg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(errorMsg, style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
