import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/features/auth/data/models/user_dto.dart';
import 'package:shopping_app/features/auth/domain/entities/user_entity.dart';

part 'login_response_dto.g.dart';

@JsonSerializable()
class LoginResponseDto {
  const LoginResponseDto({
    this.message,
    this.token,
    this.user,
  });

  final String? message;
  final String? token;
  final UserDto? user;

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDtoToJson(this);

  UserEntity toEntity() => UserEntity(
        id: '',
        name: user?.name ?? '',
        email: user?.email ?? '',
        phone: user?.phone ?? '',
        token: token ?? '',
      );
}