// import 'package:flutter/material.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/movie_seat_vo.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/seat_vo.dart';
// import 'package:hw3_movie_booking_app/resources/colors.dart';
// import 'package:hw3_movie_booking_app/resources/dimens.dart';
//
// class MovieSeatItemView extends StatelessWidget {
//
//   //final MovieSeatVO mMovieSeatVO;
//   final SeatVO mMovieSeatVO;
//
//   MovieSeatItemView({required this.mMovieSeatVO});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
//       decoration: BoxDecoration(
//         color: _getSeatColor(mMovieSeatVO),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(MARGIN_MEDIUM_2),
//           topRight: Radius.circular(MARGIN_MEDIUM_2),
//         ),
//       ),
//       child: Center(
//         child: Text(mMovieSeatVO.type == "text" ? mMovieSeatVO.symbol ?? "" : ""),
//       ),
//     );
//   }
//
//
// Color _getSeatColor(SeatVO seat){
//     if(seat.type == "taken"){
//        return MOVIE_SEAT_TAKEN_COLOR;
//     }else if(seat.type == "available"){
//       return MOVIE_SEAT_AVAILABLE_COLOR;
//     }
//     else{
//       return Colors.white;
//     }
// }
//
// }
