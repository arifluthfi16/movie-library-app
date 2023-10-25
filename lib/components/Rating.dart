import 'package:flutter/material.dart';

class RatingComponent extends StatelessWidget {
  final int rating;
  final bool isEditable;
  final void Function(int)? onRatingChanged;

  RatingComponent({
    required this.rating,
    this.isEditable = true,
    this.onRatingChanged,
  }) : assert(rating >= 1 && rating <= 5);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            if (isEditable && onRatingChanged != null) {
              onRatingChanged!(index + 1);
            }
          },
          child: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.orangeAccent,
            size: 30,
          ),
        );
      }),
    );
  }
}
