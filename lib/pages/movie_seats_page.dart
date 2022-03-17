import 'package:flutter/material.dart';
import 'package:hw3_movie_booking_app/blocs/movie_seat_page_bloc.dart';
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
import 'package:provider/provider.dart';

class MovieSeatsPage extends StatelessWidget {

  final String userChooseTime;
  final String dateData;
  final String userChooseCinema;
  final int userChoosedayTimeslotId;
  final String movieName;
  final int movieId;
  final int cinemaId;
  final String imageView;


  MovieSeatsPage({
    required this.userChooseTime,
    required this.dateData,
    required this.userChooseCinema,
    required this.userChoosedayTimeslotId,
    required this.movieName,
    required this.movieId,
    required this.cinemaId,
    required this.imageView,
  });

  List<MovieSeatVO> _movieSeats = dummyMovieSeats;

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (context) => MovieSeatPageBloc(userChoosedayTimeslotId,dateData),
      child: Scaffold(
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
                  name: movieName,
                  cinema: userChooseCinema,
                  date: dateData,
                  time: userChooseTime,
                ),
                SizedBox(
                  height: MARGIN_XXLARGE_2,
                ),
                Selector<MovieSeatPageBloc,List<SeatVO>>(
                  selector: (context,bloc) => bloc.fixedSeat ?? [],
                  builder: (context,seat,child) =>
                     Selector<MovieSeatPageBloc,int>(
                  selector: (context,bloc) => bloc.totalAmount,
                  builder: (context,amount,child) =>
                        GridView.builder(
                        itemCount: seat.length,
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
                            MovieSeatPageBloc _actionBloc = Provider.of(context,listen: false);
                            _actionBloc.userActionTakeAndRemoveSeat(seat,index,userChoosedayTimeslotId,dateData);
                           },
                            child: SeatView(
                              onChooseColor: getSeatColor(seat[index]),
                              seat: seat,
                              index: index,
                            ),
                          );
                        },
                                        ),
                     ),
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
                Selector<MovieSeatPageBloc,int>(
                  selector: (context,bloc) => bloc.pickTicketsCount,
                  builder: (context,ticketCount,child) =>
                   Selector<MovieSeatPageBloc,List<String>>(
                     selector: (context,bloc) => bloc.pickSeatNumber,
                     builder: (context,seatNumber,child) =>
                      UserTicketsAndSeatsView(
                      pickTicketsCount: ticketCount,
                      pickSeatNumber: seatNumber,
                                     ),
                   ),
                ),
                SizedBox(
                  height: MARGIN_XLARGE,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                  child: Selector<MovieSeatPageBloc,String>(
                    selector: (context,bloc) => bloc.totalRow ?? "",
                    builder: (context,row,child) =>
                     Selector<MovieSeatPageBloc,String>(
                       selector: (context,bloc) => bloc.totalSeat ?? "",
                       builder: (context,seat,child) =>
                        Selector<MovieSeatPageBloc,int>(
                           selector: (context,bloc) => bloc.totalAmount,
                           builder: (context,amount,child) =>
                          ButtonActionView(
                            onClick: () => 
                             _navigateToNextScreen(context,
                                 amount,
                                  dateData,
                                  userChoosedayTimeslotId,
                                  movieId,
                                  cinemaId,
                                  seat,
                                  row,
                                  movieName,
                                  userChooseCinema,
                                  imageView,
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
      ),
    );
  }

  Future<dynamic> _navigateToNextScreen(BuildContext context,int totalAmount,
      String dateData,int userChoosedayTimeslotId,int movieId,int cinemaId,String totalSeat,String totalRow,
      String movieName,String userChooseCinema,String imageView,
      ) {
    return Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context)=> SnapScreen(
          cost: totalAmount,
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

}

class SeatView extends StatelessWidget {

 final Color onChooseColor;
 final List<SeatVO> seat;
 final int index;

 SeatView({required this.onChooseColor,required this.seat,required this.index});

  @override
  Widget build(BuildContext context) {
    return  Container(
                            margin: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
                            decoration: BoxDecoration(
                              color: onChooseColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(MARGIN_MEDIUM_2),
                                topRight: Radius.circular(MARGIN_MEDIUM_2),
                              ),
                            ),
                            child: Center(
                              child: Text(seat[index].type == "text" ? seat[index].symbol ?? "" : seat[index].isSelected == true ? "${seat[index].id}" : "" ,
                              style: TextStyle(
                                color: seat[index].isSelected == true ? Colors.white : Colors.black,
                              ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            
                          );
  }
}


class ButtonActionView extends StatelessWidget {

  final Function onClick;

  ButtonActionView({required this.onClick});

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
                              color: PRIMARY_COLOR,
                              borderRadius: BorderRadius.circular(MARGIN_SMALL),
                          
                            ),
                            child: Center(
                              child: Selector<MovieSeatPageBloc,int>(
                                selector: (context,bloc) => bloc.totalAmount,
                                builder: (context,amount,child) =>
                                 Text(
                                  "Buy ticket for \$${amount}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                                           );
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


String seatNumbersSeparatedString(List<String> seatNumber){
  return seatNumber.map((number) => number).toList().join(",");
}


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







