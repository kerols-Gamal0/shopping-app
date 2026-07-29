import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/features/account/domain/entities/user_entity.dart';
import 'package:shopping_app/features/account/domain/use_cases/edit_user_data_usecase.dart';
import 'package:shopping_app/features/account/domain/use_cases/get_user_data_usecase.dart';

part 'account_state.dart';

abstract class AccountIntent {}

class GetUserDataIntent extends AccountIntent {}

class PickImageIntent extends AccountIntent {}

class EditUserDataIntent extends AccountIntent {}

class TogglePasswordVisibilityIntent extends AccountIntent {}

@injectable
class AccountCubit extends Cubit<AccountState> {
  final GetUserDataUseCase _getUserDataUseCase;
  final EditUserDataUseCase _editUserDataUseCase;

  AccountCubit(this._getUserDataUseCase, this._editUserDataUseCase)
    : super(AccountInitial());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  UserEntity? userEntity;
  String? selectedImagePath;
  final ImagePicker _picker = ImagePicker();

  bool isPasswordObscured = true;

  void doIntent(AccountIntent intent) {
    if (intent is GetUserDataIntent) {
      getUserData();
    } else if (intent is PickImageIntent) {
      pickImage();
    } else if (intent is EditUserDataIntent) {
      editUserData();
    } else if (intent is TogglePasswordVisibilityIntent) {
      isPasswordObscured = !isPasswordObscured;
      emit(AccountImageSelectedState(selectedImagePath ?? ''));
    }
  }

  Future<void> getUserData() async {
    emit(AccountDataState(BaseLoadingState()));
    try {
      userEntity = await _getUserDataUseCase();

      nameController.text = userEntity?.name ?? '';
      emailController.text = userEntity?.email ?? '';
      passwordController.text = '';
      phoneController.text = userEntity?.phone ?? '';
      addressController.text = userEntity?.address ?? '';

      emit(AccountDataState(BaseSuccessState(data: userEntity)));
    } catch (e) {
      emit(AccountDataState(BaseFailureState(errorMessage: e.toString())));
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImagePath = image.path;
      emit(AccountImageSelectedState(image.path));
    }
  }

  Future<void> editUserData() async {
    emit(AccountDataState(BaseLoadingState()));
    try {
      await _editUserDataUseCase(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        imagePath: selectedImagePath,
      );

      await getUserData();
    } catch (e) {
      emit(AccountDataState(BaseFailureState(errorMessage: e.toString())));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    addressController.dispose();
    return super.close();
  }
}
