import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/widgets/animated_app_logo.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/utils/validator_app.dart';
import 'package:shopping_app/features/auth/presentation/view/widgets/auth_footer.dart';
import 'package:shopping_app/features/auth/presentation/view/widgets/auth_label_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (!_formKey.currentState!.validate()) return;

    // TODO: Register Cubit
  }

  @override
  Widget build(BuildContext context) {
    final logoHeight = MediaQuery.of(context).size.height * .1;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: logoHeight),

                      Center(
                        child: SizedBox(
                          height: logoHeight,
                          child: AnimatedAppLogo(height: logoHeight),
                        ),
                      ),

                      const SizedBox(height: 24),

                      AuthLabelField(
                        title: 'Full Name',
                        controller: _nameController,
                        hintText: 'Enter your full name',
                        validator: Validator.validateName,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),

                      const SizedBox(height: 12),

                      AuthLabelField(
                        title: 'Phone Number',
                        controller: _phoneController,
                        hintText: 'Enter your phone number',
                        validator: Validator.validatePhoneNumber,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                      ),

                      const SizedBox(height: 12),

                      AuthLabelField(
                        title: 'Email',
                        controller: _emailController,
                        hintText: 'Enter your email',
                        validator: Validator.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),

                      const SizedBox(height: 12),

                      AuthLabelField(
                        title: 'Password',
                        controller: _passwordController,
                        hintText: 'Enter your password',
                        validator: Validator.validatePassword,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                      ),

                      const SizedBox(height: 12),

                      AuthLabelField(
                        title: 'Confirm Password',
                        controller: _confirmPasswordController,
                        hintText: 'Confirm your password',
                        validator: (value) => Validator.validateConfirmPassword(value, _passwordController.text),
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                      ),

                      const SizedBox(height: 32),

                      PrimaryBtn(onPressed: _register, child: const Text('Create Account')),
                    ],
                  ),
                ),
              ),

              if (MediaQuery.of(context).viewInsets.bottom == 0)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: AuthFooter(
                    text: 'Already have an account? ',
                    actionText: 'Login',
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
