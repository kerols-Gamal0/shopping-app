import 'package:dio/dio.dart';
import 'package:shopping_app/core/network/handle_dio_exceptions_service.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/core/storage_helper/shared_pref.dart';
import 'package:shopping_app/core/storage_helper/storage_key.dart';
import 'package:shopping_app/features/auth/data/models/login_request_body.dart';
import 'package:shopping_app/features/auth/data/models/register_request_body.dart';
import 'package:shopping_app/features/auth/domain/entities/user_entity.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_data_source_interface.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_repo_interface.dart';

class AuthRepoImpl implements AuthRepoInterface {
  const AuthRepoImpl(this._dataSource);
  final AuthDataSourceInterface _dataSource;

  @override
  Future<ResultApi<UserEntity>> login(LoginRequestBody body) async {
    try {
      final loginResponseDto = await _dataSource.login(body);
      final loginResponseEntity = loginResponseDto.toEntity();
      SharedPref.prefs.setString(StorageKey.token, loginResponseEntity.token);
      return Success(loginResponseEntity);
    } on DioException catch (e) {
      final String error = HandleDioExceptionsService.handle(e);
      return Error(error.toString());
    } catch (error) {
      return Error(error.toString());
    }
  }

  @override
  Future<ResultApi<void>> register(RegisterRequestBody body) async {
    try {
      await _dataSource.register(body);
      return Success(null);
    } on DioException catch (e) {
      final String error = HandleDioExceptionsService.handle(e);
      return Error(error.toString());
    } catch (error) {
      return Error(error.toString());
    }
  }
}
