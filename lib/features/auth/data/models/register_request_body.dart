import 'package:json_annotation/json_annotation.dart';

part 'register_request_body.g.dart';

@JsonSerializable()
class RegisterRequestBody {
  const RegisterRequestBody({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String name;
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;

  factory RegisterRequestBody.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestBodyToJson(this);

  RegisterRequestBody copyWith({
    String? name,
    String? phone,
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return RegisterRequestBody(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}