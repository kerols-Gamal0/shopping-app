import 'package:shopping_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shopping_app/features/auth/data/models/login_request_body.dart';
import 'package:shopping_app/features/auth/data/models/register_request_body.dart';
import 'package:shopping_app/features/auth/domain/params/login_params.dart';
import 'package:shopping_app/features/auth/domain/params/register_params.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl(this._dataSource);
  final AuthRemoteDataSource _dataSource;

  @override
  Future<void> register(RegisterParams params) async {
    await _dataSource.register(
      RegisterRequestBody(
        name: params.name,
        phone: params.phone,
        email: params.email,
        password: params.password,
        confirmPassword: params.confirmPassword,
      ),
    );
  }

  @override
  Future<void> login(LoginParams params) async {
    await _dataSource.login(LoginRequestBody(email: params.email, password: params.password));
  }
}
