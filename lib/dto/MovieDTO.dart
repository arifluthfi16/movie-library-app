
import 'package:json_annotation/json_annotation.dart';

part 'MovieDTO.g.dart';

@JsonSerializable()
class MovieDTO {
  final int id;
  final String title;
  final int releaseYear;
  final String genre;
  final int rating;
  final String description;
  final String thumbnailUrl;

  MovieDTO({
    required this.id,
    required this.title,
    required this.releaseYear,
    required this.genre,
    required this.rating,
    required this.description,
    required this.thumbnailUrl
  });

  factory MovieDTO.fromJson(Map<String, dynamic> json) => _$MovieDTOFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDTOToJson(this);
}

@JsonSerializable()
class MovieResponseDTO {
  final String message;
  final List<MovieDTO> data;

  MovieResponseDTO({required this.message, required this.data});

  factory MovieResponseDTO.fromJson(Map<String, dynamic> json) => _$MovieResponseDTOFromJson(json);
  Map<String, dynamic> toJson() => _$MovieResponseDTOToJson(this);
}

@JsonSerializable()
class SingleMovieResponseDTO {
  final String? message;
  final MovieDTO? data;
  final List<String>? errors;

  SingleMovieResponseDTO({this.message, this.data, this.errors});

  factory SingleMovieResponseDTO.fromJson(Map<String, dynamic> json) => _$SingleMovieResponseDTOFromJson(json);
  Map<String, dynamic> toJson() => _$SingleMovieResponseDTOToJson(this);
}

@JsonSerializable()
class CreateOrUpdateMovieRequestDTO {
  final String title;
  final int releaseYear;
  final String genre;
  final int rating;
  final String description;
  final String? thumbnailUrl;

  CreateOrUpdateMovieRequestDTO({
    required this.title,
    required this.releaseYear,
    required this.genre,
    required this.rating,
    required this.description,
    required this.thumbnailUrl
  });

  factory CreateOrUpdateMovieRequestDTO.fromJson(Map<String, dynamic> json) => _$CreateOrUpdateMovieRequestDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CreateOrUpdateMovieRequestDTOToJson(this);
}