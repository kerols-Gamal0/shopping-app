import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/api_constants.dart';
import 'package:shopping_app/features/auth/data/models/login_request_body.dart';
import 'package:shopping_app/features/auth/data/models/login_response_dto.dart';
import 'package:shopping_app/features/auth/data/models/register_request_body.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_data_source_interface.dart';

@Injectable(as: AuthDataSourceInterface)
class AuthRemoteDataSourceImpl implements AuthDataSourceInterface {
  const AuthRemoteDataSourceImpl(this._dio);
  final Dio _dio;

  @override
  Future<LoginResponseDto> login(LoginRequestBody body) async {
    final response = await _dio.post(ApiConstants.login, data: body.toJson()); //todo: endpoints
    return LoginResponseDto.fromJson(response.data);
  }

  @override
  Future<void> register(RegisterRequestBody body) async {
    await _dio.post(ApiConstants.register, data: body.toJson());
  }
}