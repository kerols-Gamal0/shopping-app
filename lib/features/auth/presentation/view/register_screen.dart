import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/common/widgets/custom_text_form_field.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_theme.dart';
import 'package:shopping_app/core/utils/validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up",
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
            Text(
              "Confirm Password",
              style: AppTheme.lightTheme.textTheme.headlineMedium,
            ),
            verticalSpace(5),
            CustomTextFormField(
              controller: confirmPasswordController,
              validator: (value) => Validator.validateConfirmPassword(
                value,
                passwordController.text,
              ),
              hintText: "Enter your confirm password",
              isPassword: true,
              keyboardType: TextInputType.emailAddress,
              action: TextInputAction.done,
            ),
            verticalSpace(30),
            PrimaryBtn(
              onPressed: () {},
              child: Text(
                "Login",
                style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                  fontSize: 16,
                ),
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
                  text: "Already have an account? ",
                  style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                    fontSize: 14,
                  ),

                  children: [
                    TextSpan(
                      text: "login",
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
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
