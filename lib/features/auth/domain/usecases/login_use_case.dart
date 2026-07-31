import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/data/models/login_request_body.dart';
import 'package:shopping_app/features/auth/domain/entities/user_entity.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_repo_interface.dart';

@injectable
class LoginUseCase {
  const LoginUseCase(this._repo);
  final AuthRepoInterface _repo;
  Future<ResultApi<UserEntity>> invoke(LoginRequestBody body) async => await _repo.login(body);
}
