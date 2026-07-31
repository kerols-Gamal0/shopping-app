import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/data/models/login_request_body.dart';
import 'package:shopping_app/features/auth/data/models/register_request_body.dart';
import 'package:shopping_app/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepoInterface {
  Future<ResultApi<UserEntity>> login(LoginRequestBody body);
  Future<ResultApi<void>> register(RegisterRequestBody body);
}