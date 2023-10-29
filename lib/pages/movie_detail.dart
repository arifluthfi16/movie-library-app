import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_library/api/MovieAPI.dart';
import 'package:movie_library/components/CustomButton.dart';
import 'package:movie_library/components/Rating.dart';
import 'package:movie_library/components/ThemeWrapper.dart';
import 'package:movie_library/dto/MovieDTO.dart';

import '../dto/AuthDTO.dart';
import 'create_or_update_movie.dart';

class MovieDetail extends StatelessWidget {
  final MovieDTO movie;
  final bool isFavorite;
  final Function(MovieDTO) addToFavorite;
  final UserDTO user;

  const MovieDetail({Key? key, required this.movie, required this.addToFavorite, required this.isFavorite, required this.user}) : super(key: key);

  bool isValidImageUrl(String url) {
    String imageUrlPattern = r'^(http|https)://.*\.(jpg|jpeg|png|gif|bmp)$';
    RegExp regExp = RegExp(imageUrlPattern);
    return regExp.hasMatch(url);
  }

  Widget getThumbnail () {
    String url = "https://via.placeholder.com/150x200";
    if (movie.thumbnailUrl != "" && isValidImageUrl(movie.thumbnailUrl)) url = movie.thumbnailUrl;

    return Container(
      width: 150,
      height: 200,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.fill,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }

  Widget movieDetailHeader () {
    return Container(
      height: 250,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          getThumbnail(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(movie.title,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 24
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(movie.releaseYear.toString(), style: const TextStyle(),),
                        Text(movie.genre),
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rating",
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 14
                          ),
                        ),
                        SizedBox(height: 8,),
                        RatingComponent(rating: movie.rating)
                      ],
                    ),
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }

  Widget movieBody () {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      height: double.infinity,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Description",
            style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 16
            ),
          ),
          SizedBox(height: 16,),
          Text(
            movie.description.replaceAll(r'\n', '\n'),
            softWrap: true,
            maxLines: null,
          ),
        ],
      ),
    );
  }

  void showToast (String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.lightGreen,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Delete Movie"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await MovieAPI.deleteMovie(movie.id);
                  showToast("Movie deleted, redirecting in 2 second");
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.of(context).pushReplacementNamed(
                        "/home",
                        arguments: user
                    );
                  });
                } catch (e) {
                  showToast(e.toString());
                }
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text("Movie Detail",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400
              ),
            ),
            actions: [
              Visibility(
                visible: user.role == "ADMIN",
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit_note,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return CreateOrUpdateMovieScreen(
                                user: user,
                                action: "UPDATE",
                                movieToUpdateDTO: movie,
                            );
                          },
                        ),
                      );
                    },
                  ),
              ),
              Visibility(
                visible: user.role == "ADMIN",
                child: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    showDeleteConfirmationDialog(context);
                  },
                ),
              ),
            ],
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Container(
            color: Colors.white,
            child: Column(
              children: [
                movieDetailHeader(),
                Expanded(child: movieBody()),
                Container(
                  margin: EdgeInsets.all(24),
                  child: CustomButton(
                    isDisabled: isFavorite,
                    backgroundColor: isFavorite ? Colors.lightGreen : Colors.redAccent,
                    text: isFavorite ? "Added!" : "Add to Favorite",
                    leftIcon: isFavorite ? const Icon(Icons.check) :  const Icon(Icons.favorite_outline),
                    onPressed: () {
                      if (!isFavorite) addToFavorite(movie);
                    },
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
