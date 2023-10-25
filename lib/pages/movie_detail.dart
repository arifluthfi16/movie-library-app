import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_library/components/CustomButton.dart';
import 'package:movie_library/components/Rating.dart';
import 'package:movie_library/components/ThemeWrapper.dart';
import 'package:movie_library/dto/MovieDTO.dart';

class MovieDetail extends StatelessWidget {
  final MovieDTO movie;

  const MovieDetail({Key? key, required this.movie}) : super(key: key);

  Widget movieDetailHeader () {
    return Container(
      height: 250,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 150,
            height: 200,
            decoration: const ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage("https://via.placeholder.com/150x200"),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ),
          ),
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
                  child: CustomButton(
                    backgroundColor: Colors.redAccent,
                    text: "Add to Favorite",
                    leftIcon: Icon(Icons.favorite_outline),
                  ),
                  margin: EdgeInsets.all(24),
                )
              ],
            ),
          ),
        )
    );
  }
}
