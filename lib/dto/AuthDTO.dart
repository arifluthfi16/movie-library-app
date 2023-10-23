import 'package:json_annotation/json_annotation.dart';

part 'AuthDTO.g.dart';

@JsonSerializable()
class LoginResponseDTO {
  final String message;
  final String? data;

  LoginResponseDTO({required this.message, required this.data});

  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) => _$LoginResponseDTOFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseDTOToJson(this);
}

@JsonSerializable()
class UserDTO {
  final int id;
  final String username;
  final String role;
  final String country;

  UserDTO({
    required this. id,
    required this.username,
    required this.role,
    required this.country
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) => _$UserDTOFromJson(json);
  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
}

@JsonSerializable()
class UserResponseDTO {
  final String message;
  final UserDTO data;

  UserResponseDTO({
    required this.message,
    required this.data
  });

  factory UserResponseDTO.fromJson(Map<String, dynamic> json) => _$UserResponseDTOFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseDTOToJson(this);
}
