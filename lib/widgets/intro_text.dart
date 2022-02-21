import 'package:flutter/material.dart';
import 'package:hw3_movie_booking_app/resources/colors.dart';
import 'package:hw3_movie_booking_app/resources/dimens.dart';

class IntroTextView extends StatelessWidget {
  final String title;
  final String content;
  final Color titleTextColor;
  final double? distanceBetween;
  final bool isStart;

  IntroTextView(this.title, this.content,
      {this.titleTextColor = Colors.white,
      this.distanceBetween,
      this.isStart = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isStart ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: titleTextColor,
            fontWeight: FontWeight.bold,
            fontSize: TEXT_REGULAR_5X,
          ),
        ),
        SizedBox(
          height: distanceBetween,
        ),
        Text(
          content,
          style: TextStyle(
            color: SPLASH_SCREEN_CONTENT_COLOR,
          ),
        ),
      ],
    );
  }
}
