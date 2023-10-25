

import 'package:movie_library/api/RequestWrapper.dart';
import 'package:movie_library/dto/MovieDTO.dart';

class MovieAPI {
  static const String baseUrl = "http://10.0.2.2:8082/movies";

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

}