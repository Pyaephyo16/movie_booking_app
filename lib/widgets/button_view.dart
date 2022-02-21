import 'package:flutter/material.dart';
import 'package:hw3_movie_booking_app/resources/dimens.dart';

class ButtonView extends StatelessWidget {
  final String title;
  final Color? buttonColor;
  final bool isGhostButton;
  final Function onClick;

  ButtonView(this.title,
      {this.buttonColor, this.isGhostButton = false,required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          onClick();
      },
      child: Container(
        width: double.infinity,
        height: BUTTON_HEIGHT,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(MARGIN_SMALL),
          border: isGhostButton ? Border.all(color: Colors.white) : null,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
