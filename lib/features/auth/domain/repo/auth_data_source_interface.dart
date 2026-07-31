import 'package:shopping_app/features/auth/data/models/login_request_body.dart';
import 'package:shopping_app/features/auth/data/models/login_response_dto.dart';
import 'package:shopping_app/features/auth/data/models/register_request_body.dart';

abstract interface class AuthDataSourceInterface {
  Future<LoginResponseDto> login(LoginRequestBody body);
  Future<void> register(RegisterRequestBody body);
}