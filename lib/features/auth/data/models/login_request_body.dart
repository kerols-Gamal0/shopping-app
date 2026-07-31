import 'package:json_annotation/json_annotation.dart';

part 'login_request_body.g.dart';

@JsonSerializable()
class LoginRequestBody {
  const LoginRequestBody({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  factory LoginRequestBody.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestBodyToJson(this);

  LoginRequestBody copyWith({
    String? email,
    String? password,
  }) {
    return LoginRequestBody(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}