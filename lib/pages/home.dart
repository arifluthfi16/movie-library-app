import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_library/api/MovieAPI.dart';
import 'package:movie_library/components/MovieCard.dart';
import 'package:movie_library/components/SearchBar.dart';
import 'package:movie_library/components/ThemeWrapper.dart';
import 'package:movie_library/dto/MovieDTO.dart';
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
            elevation: 0, // Remove the shadow
            title: const Text("All Movies",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400
              ),
            ),
            // Add the three buttons on the right side
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.star_outline,
                  color: Colors.orangeAccent,
                ),
                onPressed: () {
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.favorite_outline,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  color: Colors.black87,
                ),
                onPressed: () {
                  // Handle the "more" button press
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
                  child: generateMovieGrid()
              )
            ],
          ),
        ),
      ),
    );
  }
}
