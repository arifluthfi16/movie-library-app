// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseDTO _$LoginResponseDTOFromJson(Map<String, dynamic> json) =>
    LoginResponseDTO(
      message: json['message'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$LoginResponseDTOToJson(LoginResponseDTO instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => UserDTO(
      id: json['id'] as int,
      username: json['username'] as String,
      role: json['role'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'role': instance.role,
      'country': instance.country,
    };

UserResponseDTO _$UserResponseDTOFromJson(Map<String, dynamic> json) =>
    UserResponseDTO(
      message: json['message'] as String,
      data: UserDTO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResponseDTOToJson(UserResponseDTO instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
