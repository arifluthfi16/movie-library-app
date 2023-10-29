// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MovieDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDTO _$MovieDTOFromJson(Map<String, dynamic> json) => MovieDTO(
      id: json['id'] as int,
      title: json['title'] as String,
      releaseYear: json['releaseYear'] as int,
      genre: json['genre'] as String,
      rating: json['rating'] as int,
      description: json['description'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );

Map<String, dynamic> _$MovieDTOToJson(MovieDTO instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'releaseYear': instance.releaseYear,
      'genre': instance.genre,
      'rating': instance.rating,
      'description': instance.description,
      'thumbnailUrl': instance.thumbnailUrl,
    };

MovieResponseDTO _$MovieResponseDTOFromJson(Map<String, dynamic> json) =>
    MovieResponseDTO(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => MovieDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieResponseDTOToJson(MovieResponseDTO instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

SingleMovieResponseDTO _$SingleMovieResponseDTOFromJson(
        Map<String, dynamic> json) =>
    SingleMovieResponseDTO(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : MovieDTO.fromJson(json['data'] as Map<String, dynamic>),
      errors:
          (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SingleMovieResponseDTOToJson(
        SingleMovieResponseDTO instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
      'errors': instance.errors,
    };

CreateOrUpdateMovieRequestDTO _$CreateOrUpdateMovieRequestDTOFromJson(
        Map<String, dynamic> json) =>
    CreateOrUpdateMovieRequestDTO(
      title: json['title'] as String,
      releaseYear: json['releaseYear'] as int,
      genre: json['genre'] as String,
      rating: json['rating'] as int,
      description: json['description'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
    );

Map<String, dynamic> _$CreateOrUpdateMovieRequestDTOToJson(
        CreateOrUpdateMovieRequestDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'releaseYear': instance.releaseYear,
      'genre': instance.genre,
      'rating': instance.rating,
      'description': instance.description,
      'thumbnailUrl': instance.thumbnailUrl,
    };
