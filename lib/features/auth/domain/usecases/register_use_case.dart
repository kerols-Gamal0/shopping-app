import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/data/models/register_request_body.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_repo_interface.dart';

@injectable
class RegisterUseCase {
  const RegisterUseCase(this._repo);
  final AuthRepoInterface _repo;
  Future<ResultApi<void>> invoke(RegisterRequestBody body) async => await _repo.register(body);
}
