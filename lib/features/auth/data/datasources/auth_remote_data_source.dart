import 'package:shopping_app/features/auth/data/models/login_request_body.dart';
import 'package:shopping_app/features/auth/data/models/login_response_model.dart';
import 'package:shopping_app/features/auth/data/models/register_request_body.dart';

abstract interface class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestBody body);
  Future<LoginResponseModel> register(RegisterRequestBody body);
}