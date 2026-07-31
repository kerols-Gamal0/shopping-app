import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  const UserDto({
    this.name,
    this.phone,
    this.email,
    this.role,
    this.image,
  });

  final String? name;
  final String? phone;
  final String? email;
  final String? role;
  final String? image;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}