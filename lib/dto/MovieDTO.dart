
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

  MovieDTO({
    required this.id,
    required this.title,
    required this.releaseYear,
    required this.genre,
    required this.rating,
    required this.description,
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