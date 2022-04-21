import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:hw3_movie_booking_app/blocs/movie_choose_time_page_bloc.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinema_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/collection_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/timeslot_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
import 'package:hw3_movie_booking_app/pages/movie_seats_page.dart';
import 'package:hw3_movie_booking_app/resources/colors.dart';
import 'package:hw3_movie_booking_app/resources/dimens.dart';
import 'package:hw3_movie_booking_app/widgets/button_view.dart';
import 'package:provider/provider.dart';

class MovieChooseTimePage extends StatelessWidget {

  final int movieId;
  final String movieName;
  final String imageView;

  MovieChooseTimePage({
   required this.movieId,
   required this.movieName,
   required this.imageView,
});

String? getDate;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieChooseTimePageBloc(DateTime.now().toString()),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: PRIMARY_COLOR,
            leading: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.chevron_left,color: Colors.white,size: MARGIN_XLARGE,),
            )
          ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Builder(
                  builder: (context) => MovieChooseDateView(
                    selectedDate: (String? date){
                          print("date data check ==========> ${date?.split(" ")[0]}");
                          print("date data compare =======> ${DateTime.now().toString().split(" ")[0]}");
                          //getNewTimeslots(date.toString().split(" ")[0]);
                          getDate = date;
                          MovieChooseTimePageBloc _chooseTimeBloc = Provider.of(context,listen: false);
                          _chooseTimeBloc.getNewTimeslots(date ?? ""); 
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  padding: EdgeInsets.only(top: MARGIN_MEDIUM_3,left: MARGIN_MEDIUM_3,right: MARGIN_MEDIUM_3),
                  child: Selector<MovieChooseTimePageBloc,List<CinemaVO>>(
                    selector: (context,bloc) => bloc.cinemaInfo ?? [],
                    shouldRebuild: (previous,next) => previous != next,
                    builder: (context,cinema,child) =>
                    //     Selector<MovieChooseTimePageBloc,String>(
                    // selector: (context,bloc) => bloc.userChooseTime ?? "",
                    // builder: (context,chooseTime,child) =>
                           ListView.builder(
                          shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: cinema.length,
                            itemBuilder: (_,int cindex){
                              return TimeslotSectionView(
                                  cinema: cinema,
                                  cindex: cindex,
                                  onTapAction: onTapAction,
                              );
                            }
                                           ),
                       //),
                  ),
                ),
                SizedBox(height: MARGIN_LARGE,),
               Padding(
                 padding: const EdgeInsets.all(MARGIN_MEDIUM_3),
                 child: Selector<MovieChooseTimePageBloc,String>(
                   selector: (context,bloc) => bloc.dateData ?? "",
                   builder: (context,date,child) =>
                    Selector<MovieChooseTimePageBloc,String>(
                      selector: (context,bloc) => bloc.userChooseTime ?? "",
                      builder: (context,userTime,child) =>
                       Selector<MovieChooseTimePageBloc,String>(
                         selector: (context,bloc) => bloc.userChooseCinema ?? "",
                         builder: (context,userCinema,child) =>
                          Selector<MovieChooseTimePageBloc,int>(
                             selector: (context,bloc) => bloc.userChoosedayTimeslotId ?? 0,
                             builder: (context,userDayTimeslotId,child) =>
                             Selector<MovieChooseTimePageBloc,int>(
                               selector: (context,bloc) => bloc.cinemaId ?? 0,
                               builder: (context,userCinemaId,child) =>
                               ButtonView(
                                        "Next",
                                        buttonColor: PRIMARY_COLOR,
                                   onClick: ()=>
                               _navigateToNextScreen(
                                                     context,
                                                     userTime,
                                                     date,
                                                     userCinema,
                                                     userDayTimeslotId,
                                                     movieName,
                                                     movieId,
                                                     userCinemaId,
                                                    imageView,
                                             ),           
                                             ),
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
   _navigateToNextScreen(BuildContext context,String userChooseTime,String dateData,
       String userChooseCinema,int userChoosedayTimeslotId,String movieName,
       int movieId,int cinemaId,String imageView
       ) {
    if(userChooseTime != "" && userChoosedayTimeslotId != 0 && userChooseCinema != ""){
      return Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context)=>MovieSeatsPage(
         userChooseTime: userChooseTime,
           dateData: dateData,
          userChooseCinema: userChooseCinema,
          userChoosedayTimeslotId: userChoosedayTimeslotId,
          movieName: movieName,
          movieId: movieId,
          cinemaId: cinemaId,
          imageView: imageView,
        )),
      );
    }
  }


  onTapAction(List<CinemaVO> cinema,int cindex,int index,BuildContext context){
       MovieChooseTimePageBloc _actionBloc = Provider.of(context,listen: false);
                   _actionBloc.userChooseTimeAction(cinema, cindex, index);
  }

}


class MovieChooseDateView extends StatelessWidget {

  final Function(String?) selectedDate;

  MovieChooseDateView({required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_TIME_DATE_LIST_HEIGHT,
      color: PRIMARY_COLOR,
      child: Column(
        children: [
          DatePicker(
            DateTime.now(),
            daysCount: 14,
            key: Key("datePickerKey"),
            initialSelectedDate: DateTime.now(),
            selectionColor: PRIMARY_COLOR,
            selectedTextColor: Colors.white,
            onDateChange: (date) {
                 selectedDate(date.toString());
            },
          ),
        ],
      ),
    );
  }
}

class TimeslotSectionView extends StatelessWidget {

final List<CinemaVO> cinema;
final int cindex;
final Function(List<CinemaVO> cinema,int cindex,int index,BuildContext context) onTapAction;

  TimeslotSectionView({ required this.cinema,required this.cindex,required this.onTapAction});


  @override
  Widget build(BuildContext context) {
    return Container(
           margin: EdgeInsets.symmetric(vertical: 12),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
         children: [
               Text(cinema[cindex].cinema ?? "",
                style: TextStyle(
                    color: Colors.black,
                   fontSize: TEXT_REGULAR_3X,
             fontWeight: FontWeight.w700,
                       ),
                 ),
              SizedBox(height: MARGIN_MEDIUM_3,),          
                      GridView.builder(
                    itemCount: cinema[cindex].timeslots?.length ?? 0,
                          physics: NeverScrollableScrollPhysics(),
                     shrinkWrap: true,
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                       childAspectRatio: 2.5,
                      ),
                  itemBuilder: (_,index){
                       return GestureDetector(
                   onTap: (){
                   onTapAction(cinema,cindex,index,context);                                                                                               
          },
                   child:
                           Container(
                             key: Key("dateslot$cindex$index"),
                  margin: EdgeInsets.only(left: MARGIN_MEDIUM_3,right: MARGIN_MEDIUM_3,top: MARGIN_MEDIUM),
                       decoration: BoxDecoration(
                    color: cinema[cindex].timeslots?[index].isSelected == true ? PRIMARY_COLOR : Colors.white,
                    borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),         
                       border: Border.all(color: Colors.grey,width: 1),
               ),
               child: Center(child: Text(cinema[cindex].timeslots?[index].startTime ?? "",
                   style: TextStyle(
          color: cinema[cindex].timeslots?[index].isSelected == true ? Colors.white : Colors.black,
                  ),
                 )),
           ),
       );
      }
  ),
          ],
      ),
   );
  }
}
