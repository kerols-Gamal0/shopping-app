import 'package:shopping_app/features/auth/data/models/login_request_body.dart';

sealed class LoginIntent {
  const LoginIntent();
}

class Login extends LoginIntent {
  final LoginRequestBody body;
  const Login(this.body);
}
