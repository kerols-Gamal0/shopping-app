import 'package:shopping_app/features/account/domain/entities/user_entity.dart';

abstract class AccountRepoInterface {
  Future<UserEntity> getUserData();

  Future<void> editUserData({
    required String name,
    required String phone,
    required String address,
    String? imagePath,
  });
}
