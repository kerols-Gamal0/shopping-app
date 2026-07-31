import 'package:shopping_app/features/auth/domain/params/login_params.dart';
import 'package:shopping_app/features/auth/domain/params/register_params.dart';

abstract interface class AuthRepo {
  Future<void> login(LoginParams params);
  Future<void> register(RegisterParams params);
}