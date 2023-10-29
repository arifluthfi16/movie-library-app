import 'package:flutter/material.dart';
import 'package:movie_library/api/MovieAPI.dart';
import 'package:movie_library/components/SearchBar.dart';
import 'package:movie_library/components/ThemeWrapper.dart';
import 'package:movie_library/dto/MovieDTO.dart';
import 'package:movie_library/pages/create_or_update_movie.dart';
import 'package:movie_library/pages/loved_movies.dart';
import 'package:movie_library/pages/suggestion.dart';
import '../components/MovieGrid.dart';
import '../dto/AuthDTO.dart';

class HomeScreen extends StatefulWidget {
  final UserDTO user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MovieDTO> movies = [];
  List<MovieDTO> displayedMovies = [];
  List<MovieDTO> lovedMovies = [];
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
      MovieResponseDTO response = await MovieAPI.getAllMovies();
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

  void addToFavorite(MovieDTO movieToAdd) {
    if (!lovedMovies.any((movie) => movie.id == movieToAdd.id)) {
      setState(() {
        lovedMovies.add(movieToAdd);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text("All Movies",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400
              ),
            ),
            actions: [
              Visibility(
                visible: widget.user.role == "ADMIN",
                child: IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return CreateOrUpdateMovieScreen(
                            user: widget.user,
                            action: "CREATE"
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.star_outline,
                  color: Colors.orangeAccent,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SuggestedMovieScreen(
                          lovedMovies: lovedMovies,
                          addToFavorite: (MovieDTO movie) {
                            addToFavorite(movie);
                          },
                          user: widget.user,
                        );
                      },
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.favorite_outline,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return LovedMoviesScreen(
                          lovedMovies: lovedMovies,
                          addToFavorite: (MovieDTO movie) {
                            addToFavorite(movie);
                          },
                          user: widget.user,
                        );
                      },
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  color: Colors.black87,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/profile',
                    arguments: widget.user
                  );
                },
              ),
            ],
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
                  addToFavorite: addToFavorite,
                  displayedMovies: displayedMovies,
                  lovedMovies: lovedMovies,
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
