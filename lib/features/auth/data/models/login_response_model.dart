import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/features/auth/domain/entities/user_entity.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel extends UserEntity {
  const LoginResponseModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
