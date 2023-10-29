import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_library/api/MovieAPI.dart';
import 'package:movie_library/components/MovieCard.dart';
import 'package:movie_library/components/MovieGrid.dart';
import 'package:movie_library/components/SearchBar.dart';
import 'package:movie_library/components/ThemeWrapper.dart';
import 'package:movie_library/dto/MovieDTO.dart';
import '../dto/AuthDTO.dart';

class LovedMoviesScreen extends StatefulWidget {
  final UserDTO user;
  final Function(MovieDTO) addToFavorite;
  final List<MovieDTO> lovedMovies;

  const LovedMoviesScreen({Key? key, required this.user, required this.lovedMovies, required this.addToFavorite}) : super(key: key);

  @override
  State<LovedMoviesScreen> createState() => _LovedMoviesScreenState();
}

class _LovedMoviesScreenState extends State<LovedMoviesScreen> {
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
    setState(() {
      movies = widget.lovedMovies;
      displayedMovies = widget.lovedMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text("Loved Movies",
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
