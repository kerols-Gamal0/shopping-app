import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/features/account/domain/entities/user_entity.dart';
import 'package:shopping_app/features/account/presentation/view/widgets/profile_image_widget.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_cubit.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_intent.dart';

class AccountSuccessSection extends StatelessWidget {
  const AccountSuccessSection({
    super.key,
    required this.cubit,
    required this.data,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
  });

  final AccountCubit cubit;
  final UserEntity? data;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (data != null && nameController.text.isEmpty) {
      nameController.text = data!.name;
      emailController.text = data!.email;
      phoneController.text = data!.phone;
      addressController.text = data!.address;
    }

    return Padding(
      padding: AppSpacing.horizontalVerticalX2,
      child: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpace(AppSpacing.x1),
            ProfileImageWidget(cubit: cubit, userEntity: data),
            verticalSpace(AppSpacing.x4),
            _buildField(
              context,
              controller: nameController,
              label: AppStrings.accountName,
              icon: Icons.person_outline,
            ),
            verticalSpace(AppSpacing.x2),
            _buildField(
              context,
              controller: emailController,
              label: AppStrings.accountEmail,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            verticalSpace(AppSpacing.x2),
            _buildField(
              context,
              controller: phoneController,
              label: AppStrings.accountPhone,
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            verticalSpace(AppSpacing.x2),
            _buildField(
              context,
              controller: addressController,
              label: AppStrings.accountAddress,
              icon: Icons.location_on_outlined,
            ),
            verticalSpace(AppSpacing.x4),
            SizedBox(
              width: double.infinity,
              child: PrimaryBtn(
                onPressed: () => cubit.doIntent(EditUserDataIntent()),
                child: Padding(
                  padding: AppSpacing.allX1,
                  child: Text(
                    AppStrings.accountSubmit,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
            verticalSpace(AppSpacing.x2),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final inputDecorationTheme = theme.inputDecorationTheme;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: theme.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        prefixIcon: Icon(icon, color: colorScheme.primary),
        filled: inputDecorationTheme.filled,
        fillColor: inputDecorationTheme.fillColor,
        contentPadding: AppSpacing.horizontalVerticalX2,
        border: inputDecorationTheme.border,
        enabledBorder: inputDecorationTheme.enabledBorder,
        focusedBorder: inputDecorationTheme.focusedBorder,
      ),
    );
  }
}
