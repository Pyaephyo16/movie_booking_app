

import 'package:hw3_movie_booking_app/resources/strings.dart';

class MovieSeatVO{

  String type;
  String title;

  MovieSeatVO({required this.type,required this.title});

  bool isMovieSeatAvailable(){
    return type == SEAT_TYPE_AVAILABLE;
  }

  bool isMovieSeatTaken(){
    return type == SEAT_TYPE_TAKEN;
  }

  bool isMovieSeatRowTitle(){
    return type == SEAT_TYPE_TEXT;
  }
}