import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/common/widgets/custom_text_form_field.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/routing/app_routes.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_theme.dart';
import 'package:shopping_app/core/utils/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.x2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(30),
            Text("Email", style: AppTheme.lightTheme.textTheme.headlineMedium),
            verticalSpace(5),
            CustomTextFormField(
              controller: emailController,
              validator: Validator.validateEmail,
              hintText: "Enter your email",
              keyboardType: TextInputType.emailAddress,
              action: TextInputAction.next,
            ),
            verticalSpace(30),
            Text(
              "Password",
              style: AppTheme.lightTheme.textTheme.headlineMedium,
            ),
            verticalSpace(5),
            CustomTextFormField(
              controller: passwordController,
              validator: Validator.validatePassword,
              hintText: "Enter your password",
              isPassword: true,
              keyboardType: TextInputType.emailAddress,
              action: TextInputAction.next,
            ),
            verticalSpace(30),
            PrimaryBtn(
              onPressed: () {},
              child: Text(
                "Login",
                style: AppTheme.lightTheme.textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Text.rich(
                TextSpan(
                  text: "Don't have an account? ",
                  style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                    fontSize: 14,
                  ),

                  children: [
                    TextSpan(
                      text: "Sign Up",
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, AppRoutes.registerRoute);
                        },
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
