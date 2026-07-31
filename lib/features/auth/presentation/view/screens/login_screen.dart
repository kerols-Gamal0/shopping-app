import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/common/widgets/animated_app_logo.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/routing/app_routes.dart';
import 'package:shopping_app/core/utils/validator_app.dart';
import 'package:shopping_app/features/auth/data/models/login_request_body.dart';
import 'package:shopping_app/features/auth/presentation/view/widgets/auth_footer.dart';
import 'package:shopping_app/features/auth/presentation/view/widgets/auth_label_field.dart';
import 'package:shopping_app/features/auth/presentation/view_models/login/login_cubit.dart';
import 'package:shopping_app/features/auth/presentation/view_models/login/login_intent.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    context.read<LoginCubit>().intent(
      Login(
        LoginRequestBody(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      ),
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const PopScope(
          canPop: false,
          child: AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Expanded(
                  child: Text("Loading...", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: _Footer(onSignUp: () {}),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is BaseLoadingState) {
            showLoadingDialog(context);
            return;
          }
          Navigator.of(context, rootNavigator: true).pop();
          if (state is BaseFailureState) {
            final failureState = state.loginState as BaseFailureState;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(failureState.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is BaseSuccessState) {
            Navigator.pushNamed(context, AppRoutes.appSection);
          }
        },
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),

                        Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: AnimatedAppLogo(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        AuthLabelField(
                          title: 'Email',
                          controller: _emailController,
                          hintText: 'Enter your email',
                          validator: Validator.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 24),

                        AuthLabelField(
                          title: 'Password',
                          controller: _passwordController,
                          hintText: 'Enter your password',
                          validator: Validator.validatePassword,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                        ),

                        const SizedBox(height: 32),

                        PrimaryBtn(onPressed: _login, child: Text('Login')),
                      ],
                    ),
                  ),
                ),
                if (MediaQuery.of(context).viewInsets.bottom == 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: AuthFooter(
                      text: "Don't have an account? ",
                      actionText: "Sign Up",
                      onPressed: () {
                        // Navigator.pushNamed(context, AppRoutes.registerRoute);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
