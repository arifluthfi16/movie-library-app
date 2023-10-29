

import 'package:flutter/cupertino.dart';
import 'package:movie_library/api/RequestWrapper.dart';
import 'package:movie_library/dto/MovieDTO.dart';

class MovieAPI {
  static const String baseUrl = "http://moviegateway.galakita.com/movies";

  static Future<MovieResponseDTO> getAllMovies() async {
    try {
      RequestWrapper dio = RequestWrapper();
      final response = await dio.get('$baseUrl/');
      if (response.statusCode == 200) {
        return MovieResponseDTO.fromJson(response.data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  static Future<MovieResponseDTO> getSuggestedMovies() async {
    try {
      RequestWrapper dio = RequestWrapper();
      final response = await dio.get('$baseUrl/suggestion');
      if (response.statusCode == 200) {
        return MovieResponseDTO.fromJson(response.data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  static Future<SingleMovieResponseDTO> createMovie (CreateOrUpdateMovieRequestDTO requestDTO) async {
    try {
      RequestWrapper dio = RequestWrapper();
      final response = await dio.post(baseUrl, requestDTO);
      return SingleMovieResponseDTO.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  static Future<SingleMovieResponseDTO> updateMovie (int id, CreateOrUpdateMovieRequestDTO requestDTO) async {
    try {
      RequestWrapper dio = RequestWrapper();
      final response = await dio.put("$baseUrl/$id", requestDTO);
      return SingleMovieResponseDTO.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  static Future<SingleMovieResponseDTO> deleteMovie (int id) async {
    try {
      RequestWrapper dio = RequestWrapper();
      final response = await dio.delete("$baseUrl/$id");
      return SingleMovieResponseDTO.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

}