import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_library/components/CustomButton.dart';
import 'package:movie_library/components/Rating.dart';
import 'package:movie_library/components/ThemeWrapper.dart';
import 'package:movie_library/dto/MovieDTO.dart';

class MovieDetail extends StatelessWidget {
  final MovieDTO movie;
  final bool isFavorite;
  final Function(MovieDTO) addToFavorite;

  const MovieDetail({Key? key, required this.movie, required this.addToFavorite, required this.isFavorite}) : super(key: key);

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
