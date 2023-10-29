import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String genre;
  final int releaseYear;
  final String thumbnailUrl;

  const MovieCard({Key? key, required this.title, required this.genre, required this.releaseYear, required this.thumbnailUrl}) : super(key: key);

  bool isValidImageUrl(String url) {
    String imageUrlPattern = r'^(http|https)://.*\.(jpg|jpeg|png|gif|bmp)$';
    RegExp regExp = RegExp(imageUrlPattern);
    return regExp.hasMatch(url);
  }

  Widget getThumbnail () {
    String url = "https://via.placeholder.com/150x200";
    if (thumbnailUrl != "" && isValidImageUrl(thumbnailUrl)) url = thumbnailUrl;

    return Container(
      width: double.infinity,
      height: 200,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.fill,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getThumbnail(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    )
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(releaseYear.toString(), style: const TextStyle(
                      color: Color(0xFF8C76FF)
                      ),
                    ),
                    Text(genre),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
