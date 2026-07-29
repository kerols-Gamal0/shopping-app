import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/account/data/repo/account_remote_data_source.dart';
import 'package:shopping_app/features/account/domain/entities/user_entity.dart';
import 'package:shopping_app/features/account/domain/repo/account_repo_interface.dart';

@LazySingleton(as: AccountRepoInterface)
class AccountRepoImpl implements AccountRepoInterface {
  final AccountRemoteDataSource _remoteDataSource;

  AccountRepoImpl(this._remoteDataSource);

  @override
  Future<UserEntity> getUserData() async {
    final model = await _remoteDataSource.getUserData();

    return UserEntity(
      id: model.id,
      name: model.name,
      phone: model.phone,
      email: model.email,
      address: model.address,
      image: model.image,
    );
  }

  @override
  Future<void> editUserData({
    required String name,
    required String phone,
    required String address,
    String? imagePath,
  }) async {
    String? imageUrl;

    if (imagePath != null && imagePath.isNotEmpty) {
      imageUrl = await _remoteDataSource.uploadImage(imagePath);
    }

    await _remoteDataSource.editUserData(
      name: name,
      phone: phone,
      address: address,
      imageUrl: imageUrl,
    );
  }
}
