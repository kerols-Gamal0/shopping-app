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

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 640;
        final isCompactHeight = constraints.maxHeight < 620;
        final horizontalPadding = isWide ? AppSpacing.x4 : AppSpacing.x2;
        final topSpacing = isCompactHeight ? AppSpacing.x1 : AppSpacing.x3;
        final imageSpacing = isCompactHeight ? AppSpacing.x3 : AppSpacing.x5;
        final fieldSpacing = isCompactHeight ? AppSpacing.x1 : AppSpacing.x2;
        final buttonSpacing = isCompactHeight ? AppSpacing.x3 : AppSpacing.x4;

        return CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: SafeArea(
                top: false,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        topSpacing,
                        horizontalPadding,
                        AppSpacing.x3,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          verticalSpace(topSpacing),
                          ProfileImageWidget(cubit: cubit, userEntity: data),
                          verticalSpace(imageSpacing),
                          _buildField(
                            context,
                            controller: nameController,
                            label: AppStrings.accountName,
                            icon: Icons.person_outline,
                          ),
                          verticalSpace(fieldSpacing),
                          _buildField(
                            context,
                            controller: emailController,
                            label: AppStrings.accountEmail,
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            readOnly: true,
                          ),
                          verticalSpace(fieldSpacing),
                          _buildField(
                            context,
                            controller: phoneController,
                            label: AppStrings.accountPhone,
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                          ),
                          verticalSpace(fieldSpacing),
                          _buildField(
                            context,
                            controller: addressController,
                            label: AppStrings.accountAddress,
                            icon: Icons.location_on_outlined,
                          ),
                          const Spacer(),
                          verticalSpace(buttonSpacing),
                          SizedBox(
                            height: 52,
                            child: PrimaryBtn(
                              onPressed: () => cubit.doIntent(
                                EditUserDataIntent(),
                                updatedData: {
                                  'name': nameController.text.trim(),
                                  'phone': phoneController.text.trim(),
                                  'address': addressController.text.trim(),
                                },
                              ),
                              child: Text(
                                AppStrings.accountSubmit,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final inputDecorationTheme = theme.inputDecorationTheme;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
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
