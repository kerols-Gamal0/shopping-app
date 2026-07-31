import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shopping_app/features/auth/data/models/login_request_body.dart';
import 'package:shopping_app/features/auth/data/models/login_response_model.dart';
import 'package:shopping_app/features/auth/data/models/register_request_body.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._dio);
  final Dio _dio;

  @override
  Future<LoginResponseModel> login(LoginRequestBody body) async {
    final response = await _dio.post('/auth/login', data: body.toJson());
    return LoginResponseModel.fromJson(response.data);
  }

  @override
  Future<LoginResponseModel> register(RegisterRequestBody body) async {
    final response = await _dio.post('/auth/register', data: body.toJson());
    return LoginResponseModel.fromJson(response.data);
  }
}
