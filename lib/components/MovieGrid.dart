import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_library/components/MovieCard.dart';
import 'package:movie_library/dto/MovieDTO.dart';
import 'package:movie_library/pages/movie_detail.dart';

class MovieGrid extends StatelessWidget {
  final List<MovieDTO> displayedMovies;
  final Function(MovieDTO) addToFavorite;
  final List<MovieDTO> lovedMovies;

  const MovieGrid({
    super.key,
    required this.displayedMovies,
    required this.addToFavorite,
    required this.lovedMovies
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StaggeredGrid.count(
          crossAxisCount: 2,
          children: displayedMovies.map((e) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return MovieDetail(
                        isFavorite: lovedMovies.any((movie) => movie.id == e.id),
                        movie: e,
                        addToFavorite: (MovieDTO movie) {
                          addToFavorite(movie);
                        },
                      );
                    },
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                child: MovieCard(
                  title: e.title,
                  genre: e.genre,
                  releaseYear: e.releaseYear,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
