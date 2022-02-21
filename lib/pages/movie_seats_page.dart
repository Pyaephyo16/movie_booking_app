// import 'package:flutter/material.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/movie_seat_vo.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/seat_vo.dart';
// import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
// import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
// import 'package:hw3_movie_booking_app/dummy/dummy_data.dart';
// import 'package:hw3_movie_booking_app/pages/snack_screen.dart';
// import 'package:hw3_movie_booking_app/resources/colors.dart';
// import 'package:hw3_movie_booking_app/resources/dimens.dart';
// import 'package:hw3_movie_booking_app/resources/strings.dart';
// import 'package:hw3_movie_booking_app/viewitems/DottedLineSectionView.dart';
// //import 'package:hw3_movie_booking_app/viewitems/movie_seat_item_view.dart';
// import 'package:dotted_line/dotted_line.dart';
// import 'package:hw3_movie_booking_app/widgets/button_view.dart';
// import 'package:intl/intl.dart';
//
// class MovieSeatsPage extends StatefulWidget {
//
//   final String userChooseTime;
//   final String dateData;
//   final String userChooseCinema;
//   final int userChoosedayTimeslotId;
//   final String movieName;
//   final String token;
//
//   MovieSeatsPage({
//     required this.userChooseTime,
//     required this.dateData,
//     required this.userChooseCinema,
//     required this.userChoosedayTimeslotId,
//     required this.movieName,
//     required this.token,
//   });
//
//
//   @override
//   State<MovieSeatsPage> createState() => _MovieSeatsPageState();
// }
//
// class _MovieSeatsPageState extends State<MovieSeatsPage> {
//
//   List<MovieSeatVO> _movieSeats = dummyMovieSeats;
//
//   ///Movie Model
//   MovieModel movieModel = MovieModelImpl();
//
//   ///State Variables
//   List<SeatVO>? fixedSeat;
//   int pickTicketsCount = 0;
//   List<String> pickSeatNumber = [];
//
//   @override
//   void initState() {
//
//     ///Get Cinema Seating Plan
//     movieModel.getCinemaSeatingPlan("Bearer ${widget.token}",widget.userChoosedayTimeslotId.toString(), widget.dateData.split(" ")[0])
//     .then((value){
//       setState(() {
//           fixedSeat = value;
//       });
//     }).catchError((error){
//       debugPrint("Get Cinema Seating Plan Error ======> ${error.toString()}");
//     });
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: (){
//             Navigator.of(context).pop();
//           },
//           icon: Icon(Icons.chevron_left,
//             color: Colors.black,
//             size: MARGIN_XLARGE,),
//         ),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               MovieNameTimeAndCinemaSectionView(
//                 name: widget.movieName,
//                 cinema: widget.userChooseCinema,
//                 date: widget.dateData,
//                 time: widget.userChooseTime,
//               ),
//               SizedBox(
//                 height: MARGIN_XXLARGE_2,
//               ),
//               //MovieSeatsSectionView(movieSeats: _movieSeats),
//               MovieSeatsSectionView(
//                   movieSeats: fixedSeat ?? [],
//                 userChoice: (chooseSeat){
//                      userPickSeat(chooseSeat ?? false);
//                       print("User Choose in page lvl ====================================> ${chooseSeat}");
//                 },
//               ),
//               SizedBox(
//                 height: MARGIN_MEDIUM_3,
//               ),
//               MovieSeatsGlossarySectionView(),
//               SizedBox(
//                 height: MARGIN_XLARGE,
//               ),
//               DottedLineSectionView(),
//               SizedBox(
//                 height: MARGIN_XLARGE,
//               ),
//               NumberOfSeatsAndTicketsSectionView(
//                 ticketCount: pickTicketsCount,
//                 seatNumber: pickSeatNumber,
//               ),
//               SizedBox(
//                 height: MARGIN_XLARGE,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
//                 child: ButtonView(
//                   "Buy ticket for \$20",
//                   buttonColor: SPLASH_SCREEN_BACKGROUND_COLOR,
//                   onClick: ()=> _navigateToNextScreen(context),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<dynamic> _navigateToNextScreen(BuildContext context) {
//     return Navigator.push(context,
//                 MaterialPageRoute(builder: (BuildContext context)=> SnapScreen()),
//                 );
//   }
//
//  bool userPickSeat(bool userChoice){
//     bool isOn = true;
//     bool nowState = userChoice;
//     setState(() {
//         nowState = !isOn;
//     });
//     return nowState;
//   }
//
//
//
// }
//
// class NumberOfSeatsAndTicketsSectionView extends StatelessWidget {
//
//  final int ticketCount;
//  final List<String> seatNumber;
//
//  NumberOfSeatsAndTicketsSectionView({
//    required this.ticketCount,
//    required this.seatNumber
// });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Text(
//                 "Tickets",
//                 style: TextStyle(
//                   color: MVOIE_TIME_COLOR,
//                   fontSize: TEXT_REGULAR_2X,
//                 ),
//               ),
//               Spacer(),
//               Text(
//                  "${ticketCount}",
//                 style: TextStyle(
//                   color: MVOIE_TIME_COLOR,
//                   fontSize: TEXT_REGULAR_2X,
//                 ),
//               )
//             ],
//           ),
//           SizedBox(
//             height: MARGIN_MEDIUM_2,
//           ),
//           Row(
//             children: [
//               Text(
//                 "Seats",
//                 style: TextStyle(
//                   color: MVOIE_TIME_COLOR,
//                   fontSize: TEXT_REGULAR_2X,
//                 ),
//               ),
//               Spacer(),
//               Text(
//                 seatNumber.isEmpty ? "-" : "${seatNumbersSeparatedString(seatNumber)}",
//                 style: TextStyle(
//                   color: MVOIE_TIME_COLOR,
//                   fontSize: TEXT_REGULAR_2X,
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
// String seatNumbersSeparatedString(List<String> seatNumber){
//     return seatNumber.map((number) => number).toList().join(",");
// }
//
// class NumberOfTicketAndSeatsView extends StatelessWidget {
//   final String mTitle;
//   final String mInfo;
//
//   NumberOfTicketAndSeatsView({required this.mTitle,required this.mInfo});
//
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           mTitle,
//           style: TextStyle(
//             color: MVOIE_TIME_COLOR,
//             fontSize: TEXT_REGULAR_2X,
//           ),
//         ),
//         Spacer(),
//         Text(
//           mInfo,
//           style: TextStyle(
//             color: MVOIE_TIME_COLOR,
//             fontSize: TEXT_REGULAR_2X,
//           ),
//         )
//       ],
//     );
//   }
// }
//
// class MovieSeatsGlossarySectionView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
//       child: Row(
//         children: [
//           Expanded(
//               flex: 1,
//               child: MovieSeatGlossaryView(
//                 MOVIE_SEAT_AVAILABLE_COLOR,
//                 LABEL_AVAILABLE,
//               )),
//           Expanded(
//               flex: 1,
//               child: MovieSeatGlossaryView(
//                 MOVIE_SEAT_TAKEN_COLOR,
//                 LABEL_TAKEN,
//               )),
//           Expanded(
//               flex: 1,
//               child: MovieSeatGlossaryView(
//                 SPLASH_SCREEN_BACKGROUND_COLOR,
//                 LABEL_YOUR_SELECTION,
//               )),
//         ],
//       ),
//     );
//   }
// }
//
// class MovieSeatsSectionView extends StatelessWidget {
//  // MovieSeatsSectionView({
//  //    required List<MovieSeatVO> movieSeats,
//  //  })  : _movieSeats = movieSeats;
//  //
//  //  final List<MovieSeatVO> _movieSeats;
//
//   final List<SeatVO> movieSeats;
//   Function(bool?) userChoice;
//
//   MovieSeatsSectionView({
//     required this.movieSeats,
//     required this.userChoice,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       itemCount: movieSeats.length,
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 14,
//         childAspectRatio: 1,
//       ),
//       itemBuilder: (BuildContext context, int index) {
//         return MovieSeatItemView(
//             mMovieSeatVO: movieSeats[index],
//             userChoice: (chooseSeat){
//               print("User Choose in MovieSeatSectionView ====================================> ${chooseSeat}");
//               this.userChoice(chooseSeat);
//             },
//         );
//       },
//     );
//   }
// }
//
// class MovieSeatGlossaryView extends StatelessWidget {
//   final Color mGlossaryColor;
//   final String mTitle;
//
//   MovieSeatGlossaryView(this.mGlossaryColor, this.mTitle);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: MARGIN_XLARGE,
//           height: MARGIN_XLARGE,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: mGlossaryColor,
//           ),
//         ),
//         SizedBox(
//           width: MARGIN_MEDIUM_2,
//         ),
//         Expanded(
//           child: Text(
//             mTitle,
//             style: TextStyle(
//               color: MVOIE_TIME_COLOR,
//               fontSize: TEXT_REGULAR_2X,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class MovieNameTimeAndCinemaSectionView extends StatelessWidget {
//
//   final String name;
//   final String cinema;
//   final String date;
//   final String time;
//
//   MovieNameTimeAndCinemaSectionView({
//       required this.name,required this.cinema,required this.date,required this.time});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           name,
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: TEXT_REGULAR_3X,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         SizedBox(
//           height: MARGIN_SMALL,
//         ),
//         Text(
//           cinema,
//           style: TextStyle(
//             color: MOVIE_CINEMA_COLOR,
//             fontSize: TEXT_REGULAR_2X,
//           ),
//         ),
//         SizedBox(
//           height: MARGIN_SMALL,
//         ),
//         Text(
//           "${DateFormat("EEEE, dd-MMMM").format(DateTime.parse(date))}, ${time}",
//           style: TextStyle(
//             color: MVOIE_TIME_COLOR,
//             fontSize: TEXT_REGULAR_2X,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class MovieSeatItemView extends StatelessWidget {
//
//   //final MovieSeatVO mMovieSeatVO;
//   final SeatVO mMovieSeatVO;
//   final Function(bool?) userChoice;
//
//   MovieSeatItemView({
//     required this.mMovieSeatVO,
//     required this.userChoice,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         print("User Choose in MovieSEatItemView ====================================> ${mMovieSeatVO.isSelected}");
//         userChoice(mMovieSeatVO.isSelected);
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
//         decoration: BoxDecoration(
//           color: getSeatColor(mMovieSeatVO),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(MARGIN_MEDIUM_2),
//             topRight: Radius.circular(MARGIN_MEDIUM_2),
//           ),
//         ),
//         child: Center(
//           child: Text(mMovieSeatVO.type == "text" ? mMovieSeatVO.symbol ?? "" : ""),
//         ),
//       ),
//     );
//   }
//
//   Color getSeatColor(SeatVO seat){
//     if(seat.type == "taken"){
//       return MOVIE_SEAT_TAKEN_COLOR;
//     }else if(seat.type == "available"){
//         if(seat.type == "available" && seat.isSelected == true){
//           return PRIMARY_COLOR;
//         }
//       return MOVIE_SEAT_AVAILABLE_COLOR;
//     }
//     else{
//       return Colors.white;
//     }
//   }
//
// }
//
//
//

import 'package:flutter/material.dart';
import 'package:hw3_movie_booking_app/data/data.vos/movie_seat_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/seat_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
import 'package:hw3_movie_booking_app/dummy/dummy_data.dart';
import 'package:hw3_movie_booking_app/pages/snack_screen.dart';
import 'package:hw3_movie_booking_app/resources/colors.dart';
import 'package:hw3_movie_booking_app/resources/dimens.dart';
import 'package:hw3_movie_booking_app/resources/strings.dart';
import 'package:hw3_movie_booking_app/viewitems/DottedLineSectionView.dart';
//import 'package:hw3_movie_booking_app/viewitems/movie_seat_item_view.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:hw3_movie_booking_app/widgets/button_view.dart';
import 'package:intl/intl.dart';

class MovieSeatsPage extends StatefulWidget {

  final String userChooseTime;
  final String dateData;
  final String userChooseCinema;
  final int userChoosedayTimeslotId;
  final String movieName;
  final String token;
  final int movieId;
  final int cinemaId;
  final String imageView;


  MovieSeatsPage({
    required this.userChooseTime,
    required this.dateData,
    required this.userChooseCinema,
    required this.userChoosedayTimeslotId,
    required this.movieName,
    required this.token,
    required this.movieId,
    required this.cinemaId,
    required this.imageView,
  });


  @override
  State<MovieSeatsPage> createState() => _MovieSeatsPageState();
}

class _MovieSeatsPageState extends State<MovieSeatsPage> {

  List<MovieSeatVO> _movieSeats = dummyMovieSeats;

  ///Movie Model
  MovieModel movieModel = MovieModelImpl();

  ///State Variables
  List<SeatVO>? fixedSeat;
  int pickTicketsCount = 0;
  List<String> pickSeatNumber = [];
  int totalAmount = 0;
  List<String> seatRow = [];

  String? totalSeat;
  String? totalRow;

  @override
  void initState() {

    ///Get Cinema Seating Plan
    //"Bearer ${widget.token}",
    movieModel.getCinemaSeatingPlan(widget.userChoosedayTimeslotId.toString(), widget.dateData.split(" ")[0])
        .then((value){
      setState(() {
        fixedSeat = value;
      });
    }).catchError((error){
      debugPrint("Get Cinema Seating Plan Error ======> ${error.toString()}");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.chevron_left,
            color: Colors.black,
            size: MARGIN_XLARGE,),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MovieNameTimeAndCinemaSectionView(
                name: widget.movieName,
                cinema: widget.userChooseCinema,
                date: widget.dateData,
                time: widget.userChooseTime,
              ),
              SizedBox(
                height: MARGIN_XXLARGE_2,
              ),
              GridView.builder(
                itemCount: fixedSeat?.length ?? 0,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 14,
                  childAspectRatio: 1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        if(fixedSeat?[index].isSelected == false && fixedSeat?[index].type != "taken") {
                          fixedSeat?[index].isSelected = true;
                          pickTicketsCount++;
                          String name = fixedSeat?[index].seatName ?? "";
                          pickSeatNumber.add(name);
                          int price = fixedSeat?[index].price??0;
                          totalAmount = totalAmount+price;
                          seatRow.add(fixedSeat?[index].symbol ?? "");
                        }
                        else if(
                        fixedSeat?[index].isSelected == true && fixedSeat?[index].type != "taken"){
                          fixedSeat?[index].isSelected = false;
                          pickTicketsCount--;
                          String name = fixedSeat?[index].seatName ?? "";
                          pickSeatNumber.remove(name);
                          int price = fixedSeat?[index].price??0;
                          totalAmount = totalAmount-price;
                          seatRow.remove(fixedSeat?[index].symbol ?? "");
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
                      decoration: BoxDecoration(
                        color: getSeatColor(fixedSeat![index]),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(MARGIN_MEDIUM_2),
                          topRight: Radius.circular(MARGIN_MEDIUM_2),
                        ),
                      ),
                      child: Center(
                        child: Text(fixedSeat![index].type == "text" ? fixedSeat![index].symbol ?? "" : fixedSeat![index].isSelected == true ? "${fixedSeat![index].id}" : "" ,
                        style: TextStyle(
                          color: fixedSeat![index].isSelected == true ? Colors.white : Colors.black,
                        ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: MARGIN_MEDIUM_3,
              ),
              MovieSeatsGlossarySectionView(),
              SizedBox(
                height: MARGIN_XLARGE,
              ),
              DottedLineSectionView(),
              SizedBox(
                height: MARGIN_XLARGE,
              ),
              UserTicketsAndSeatsView(
                pickTicketsCount: pickTicketsCount,
                pickSeatNumber: pickSeatNumber,
              ),
              SizedBox(
                height: MARGIN_XLARGE,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                child: GestureDetector(
                  onTap: (){
                     totalRow = seatRowSeparatedString(seatRow);
                     totalSeat = seatNumbersSeparatedString(pickSeatNumber);
                    print("Total Row ========> ${totalRow}");
                     print("Total Seat ========> ${totalSeat}");



                     print("Image check seat screen ${widget.imageView}");
                     _navigateToNextScreen(context,
                         totalAmount,
                         widget.token,
                          widget.dateData,
                          widget.userChoosedayTimeslotId,
                          widget.movieId,
                          widget.cinemaId,
                          totalSeat ?? "",
                          totalRow ?? "",
                          widget.movieName,
                          widget.userChooseCinema,
                          widget.imageView,
                     );
                  },
                  child: Container(
                    width: double.infinity,
                    height: BUTTON_HEIGHT,
                    decoration: BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(MARGIN_SMALL),

                    ),
                    child: Center(
                      child: Text(
                        "Buy ticket for \$${totalAmount}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToNextScreen(BuildContext context,int totalAmount,String token,
      String dateData,int userChoosedayTimeslotId,int movieId,int cinemaId,String totalSeat,String totalRow,
      String movieName,String userChooseCinema,String imageView,
      ) {
    return Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context)=> SnapScreen(
          cost: totalAmount,
          token: token,
          dateData: dateData,
          userChoosedayTimeslotId: userChoosedayTimeslotId,
          movieId: movieId,
          cinemaId: cinemaId,
          totalSeat: totalSeat,
          totalRow: totalRow,
          movieName: movieName,
          userChooseCinema: userChooseCinema,
          imageView: imageView,
      )),
    );
  }


  Color getSeatColor(SeatVO seat){
    if(seat.type == "taken"){
      return MOVIE_SEAT_TAKEN_COLOR;
    }else if(seat.type == "available"){
      if(seat.type == "available" && seat.isSelected == true){
        return PRIMARY_COLOR;
      }
      return MOVIE_SEAT_AVAILABLE_COLOR;
    }
    else{
      return Colors.white;
    }
  }

  String seatNumbersSeparatedString(List<String> seatNumber){
    return seatNumber.map((number) => number).toList().join(",");
  }

  String seatRowSeparatedString(List<String> seatRow){
    return seatRow.map((row) => row).toList().join(",");
  }

  bool userPickSeat(bool userChoice){
    bool isOn = true;
    bool nowState = userChoice;
    setState(() {
      nowState = !isOn;
    });
    return nowState;
  }



}

class UserTicketsAndSeatsView extends StatelessWidget {

  final int pickTicketsCount;
  final List<String> pickSeatNumber;

  UserTicketsAndSeatsView({required this.pickTicketsCount,required this.pickSeatNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                LABEL_TICKETS,
                style: TextStyle(
                  color: MVOIE_TIME_COLOR,
                  fontSize: TEXT_REGULAR_2X,
                ),
              ),
              Spacer(),
              Text(
                "${pickTicketsCount}",
                style: TextStyle(
                  color: MVOIE_TIME_COLOR,
                  fontSize: TEXT_REGULAR_2X,
                ),
              )
            ],
          ),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  LABEL_SEATS,
                  style: TextStyle(
                    color: MVOIE_TIME_COLOR,
                    fontSize: TEXT_REGULAR_2X,
                  ),
                ),
              ),
              //Spacer(),
              Expanded(
                child: Text(
                 pickSeatNumber.isEmpty ? "-" : "${seatNumbersSeparatedString(pickSeatNumber)}",
                  style: TextStyle(
                    color: MVOIE_TIME_COLOR,
                    fontSize: TEXT_REGULAR_2X,
                  ),
                  maxLines: null,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class NumberOfSeatsAndTicketsSectionView extends StatelessWidget {

  final int ticketCount;
  final List<String> seatNumber;

  NumberOfSeatsAndTicketsSectionView({
    required this.ticketCount,
    required this.seatNumber
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Tickets",
                style: TextStyle(
                  color: MVOIE_TIME_COLOR,
                  fontSize: TEXT_REGULAR_2X,
                ),
              ),
              Spacer(),
              Text(
                "${ticketCount}",
                style: TextStyle(
                  color: MVOIE_TIME_COLOR,
                  fontSize: TEXT_REGULAR_2X,
                ),
              )
            ],
          ),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          Row(
            children: [
              Text(
                "Seats",
                style: TextStyle(
                  color: MVOIE_TIME_COLOR,
                  fontSize: TEXT_REGULAR_2X,
                ),
              ),
              Spacer(),
              Text(
                seatNumber.isEmpty ? "-" : "${seatNumbersSeparatedString(seatNumber)}",
                style: TextStyle(
                  color: MVOIE_TIME_COLOR,
                  fontSize: TEXT_REGULAR_2X,
                ),
                textAlign: TextAlign.right,
              )
            ],
          )
        ],
      ),
    );
  }
}

String seatNumbersSeparatedString(List<String> seatNumber){
  return seatNumber.map((number) => number).toList().join(",");
}

// class NumberOfTicketAndSeatsView extends StatelessWidget {
//   final String mTitle;
//   final String mInfo;
//
//   NumberOfTicketAndSeatsView({required this.mTitle,required this.mInfo});
//
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           mTitle,
//           style: TextStyle(
//             color: MVOIE_TIME_COLOR,
//             fontSize: TEXT_REGULAR_2X,
//           ),
//         ),
//         Spacer(),
//         Text(
//           mInfo,
//           style: TextStyle(
//             color: MVOIE_TIME_COLOR,
//             fontSize: TEXT_REGULAR_2X,
//           ),
//         )
//       ],
//     );
//   }
// }

class MovieSeatsGlossarySectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: MovieSeatGlossaryView(
                MOVIE_SEAT_AVAILABLE_COLOR,
                LABEL_AVAILABLE,
              )),
          Expanded(
              flex: 1,
              child: MovieSeatGlossaryView(
                MOVIE_SEAT_TAKEN_COLOR,
                LABEL_TAKEN,
              )),
          Expanded(
              flex: 1,
              child: MovieSeatGlossaryView(
                SPLASH_SCREEN_BACKGROUND_COLOR,
                LABEL_YOUR_SELECTION,
              )),
        ],
      ),
    );
  }
}

class MovieSeatsSectionView extends StatelessWidget {
  // MovieSeatsSectionView({
  //    required List<MovieSeatVO> movieSeats,
  //  })  : _movieSeats = movieSeats;
  //
  //  final List<MovieSeatVO> _movieSeats;

  final List<SeatVO> movieSeats;
  Function(bool?) userChoice;

  MovieSeatsSectionView({
    required this.movieSeats,
    required this.userChoice,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movieSeats.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 14,
        childAspectRatio: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        return MovieSeatItemView(
          mMovieSeatVO: movieSeats[index],
          userChoice: (chooseSeat){
            print("User Choose in MovieSeatSectionView ====================================> ${chooseSeat}");
            this.userChoice(chooseSeat);
          },
        );
      },
    );
  }
}

class MovieSeatGlossaryView extends StatelessWidget {
  final Color mGlossaryColor;
  final String mTitle;

  MovieSeatGlossaryView(this.mGlossaryColor, this.mTitle);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MARGIN_XLARGE,
          height: MARGIN_XLARGE,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: mGlossaryColor,
          ),
        ),
        SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        Expanded(
          child: Text(
            mTitle,
            style: TextStyle(
              color: MVOIE_TIME_COLOR,
              fontSize: TEXT_REGULAR_2X,
            ),
          ),
        ),
      ],
    );
  }
}

class MovieNameTimeAndCinemaSectionView extends StatelessWidget {

  final String name;
  final String cinema;
  final String date;
  final String time;

  MovieNameTimeAndCinemaSectionView({
    required this.name,required this.cinema,required this.date,required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
            color: Colors.black,
            fontSize: TEXT_REGULAR_3X,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        Text(
          cinema,
          style: TextStyle(
            color: MOVIE_CINEMA_COLOR,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        Text(
          "${DateFormat("EEEE, dd-MMMM").format(DateTime.parse(date))}, ${time}",
          style: TextStyle(
            color: MVOIE_TIME_COLOR,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class MovieSeatItemView extends StatelessWidget {

  //final MovieSeatVO mMovieSeatVO;
  final SeatVO mMovieSeatVO;
  final Function(bool?) userChoice;

  MovieSeatItemView({
    required this.mMovieSeatVO,
    required this.userChoice,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("User Choose in MovieSEatItemView ====================================> ${mMovieSeatVO.isSelected}");
        userChoice(mMovieSeatVO.isSelected);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
        decoration: BoxDecoration(
          color: getSeatColor(mMovieSeatVO),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(MARGIN_MEDIUM_2),
            topRight: Radius.circular(MARGIN_MEDIUM_2),
          ),
        ),
        child: Center(
          child: Text(mMovieSeatVO.type == "text" ? mMovieSeatVO.symbol ?? "" : ""),
        ),
      ),
    );
  }

  Color getSeatColor(SeatVO seat){
    if(seat.type == "taken"){
      return MOVIE_SEAT_TAKEN_COLOR;
    }else if(seat.type == "available"){
      if(seat.type == "available" && seat.isSelected == true){
        return PRIMARY_COLOR;
      }
      return MOVIE_SEAT_AVAILABLE_COLOR;
    }
    else{
      return Colors.white;
    }
  }

}



