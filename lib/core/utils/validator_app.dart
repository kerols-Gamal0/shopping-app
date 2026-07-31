import 'package:shopping_app/core/constants/app_strings.dart';

abstract final class AppRegex {
  static const email = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$";

  static const password = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$';

  static const username = r'^[a-zA-Z0-9,.-]+$';

  static const phone = r'^\+?\d+$';
}

abstract final class Validator {
  static String? validateEmail(String? value) {
    final error = _isEmpty(value, AppStrings.emailEmpty);
    if (error != null) return error;

    return RegExp(AppRegex.email).hasMatch(value!.trim()) ? null : AppStrings.invalidEmail;
  }

  static String? validatePassword(String? value) {
    final error = _isEmpty(value, AppStrings.passwordEmpty);
    if (error != null) return error;

    return RegExp(AppRegex.password).hasMatch(value!) ? null : AppStrings.invalidPassword;
  }

  static String? validateConfirmPassword(String? value, String password) {
    final error = _isEmpty(value, AppStrings.confirmPasswordEmpty);
    if (error != null) return error;

    return value == password ? null : AppStrings.passwordsDoNotMatch;
  }

  static String? validateName(String? value) => _isEmpty(value, AppStrings.nameEmpty);

  static String? validatePhoneNumber(String? value) {
    final error = _isEmpty(value, AppStrings.phoneEmpty);
    if (error != null) return error;

    final phone = value!.trim();

    return RegExp(AppRegex.phone).hasMatch(phone) && phone.length == 13 ? null : AppStrings.invalidPhone;
  }

  static String? validateCode(String? value) {
    final error = _isEmpty(value, AppStrings.codeEmpty);
    if (error != null) return error;

    return value!.length >= 6 ? null : AppStrings.invalidCode;
  }

  static String? _isEmpty(String? value, String message) {
    return value == null || value.trim().isEmpty ? message : null;
  }
}
