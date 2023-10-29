import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_library/api/MovieAPI.dart';
import 'package:movie_library/components/MovieCard.dart';
import 'package:movie_library/components/MovieGrid.dart';
import 'package:movie_library/components/SearchBar.dart';
import 'package:movie_library/components/ThemeWrapper.dart';
import 'package:movie_library/dto/MovieDTO.dart';
import '../dto/AuthDTO.dart';

class SuggestedMovieScreen extends StatefulWidget {
  final UserDTO user;
  final Function(MovieDTO) addToFavorite;
  final List<MovieDTO> lovedMovies;

  const SuggestedMovieScreen({Key? key, required this.user, required this.addToFavorite, required this.lovedMovies}) : super(key: key);

  @override
  State<SuggestedMovieScreen> createState() => _SuggestedMovieScreenState();
}

class _SuggestedMovieScreenState extends State<SuggestedMovieScreen> {
  List<MovieDTO> movies = [];
  List<MovieDTO> displayedMovies = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getMovies();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String query = searchController.text.toLowerCase();
    if (query.isEmpty || query == "") {
      setState(() {
        displayedMovies = movies;
      });
    } else {
      setState(() {
        displayedMovies = movies
            .where((movie) => movie.title.toLowerCase().contains(query))
            .toList();
      });
    }
  }

  void getMovies() async {
    try {
      MovieResponseDTO response = await MovieAPI.getSuggestedMovies();
      if(response.data.isNotEmpty)  {
        setState(() {
          movies = response.data;
          displayedMovies = response.data;
        });
      }

    } catch (e) {
      setState(() {
        movies = [];
        displayedMovies = [];
      });
    }
  }

  Widget generateMovieGrid () {
    if (displayedMovies.isEmpty) return Container();
    return ListView(
      children: [
        StaggeredGrid.count(
            crossAxisCount: 2,
            children: displayedMovies.map((e) => GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                    "/detail",
                    arguments: e
                );
              },
              child: Container(
                  margin: const EdgeInsets.all(8),
                  child: MovieCard(
                    title: e.title,
                    genre: e.genre,
                    releaseYear: e.releaseYear,
                    thumbnailUrl: e.thumbnailUrl,
                  )
              ),
            )).toList()
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text("Suggested Movies",
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              color: Colors.white
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(vertical: 16), child: CustomSearchBar(
                controller: searchController,
              )),
              Expanded(
                  child: MovieGrid(
                    addToFavorite: widget.addToFavorite,
                    displayedMovies: displayedMovies,
                    lovedMovies: widget.lovedMovies,
                    user: widget.user,
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
