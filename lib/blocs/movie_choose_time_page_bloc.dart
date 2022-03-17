import 'package:flutter/foundation.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinema_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/timeslot_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';

class MovieChooseTimePageBloc extends ChangeNotifier{

///Movie Model
  MovieModel movieModel = MovieModelImpl();

  ///State Variables
  List<CinemaVO>? cinemaInfo;

  String? dateData;
   String? userChooseTime;
   String? userChooseCinema;
   int? userChoosedayTimeslotId;
   int? cinemaId;


MovieChooseTimePageBloc(String startDate){

 // ///Cinema Day Timeslot Database
      movieModel.getCinemaDayTimeslotDatabase(startDate).listen((value) {
          print("Get Cinema DayTimeslot in view layer ==============> ${value?.cinemaList}");
          //cinemaInfo = value.cast<CinemaVO>();
          cinemaInfo = value?.cinemaList;
          dateData = startDate.split(" ")[0];
          notifyListeners();
          return;
      });
      //getNewTimeslots(startDate);

}

getNewTimeslots(String date){
    movieModel.getCinemaDayTimeslotDatabase(date.split(" ")[0]).listen((value) {
          print("Get Cinema DayTimeslot with new date in view layer ==============> ${value?.cinemaList}");
          //cinemaInfo = value.cast<CinemaVO>();
          cinemaInfo = value?.cinemaList;
          dateData = date.split(" ")[0];
          notifyListeners();
      });
  }
  
       List<CinemaVO>? userChooseTimeAction(List<CinemaVO> cinema,int cindex,int index){
                                cinemaInfo?.forEach((outer) {
                                  outer.timeslots?.forEach((inner) {
                                       inner.isSelected = false;
                                            });
                               });
                               notifyListeners();
                          cinemaInfo?[cindex].timeslots?[index].isSelected = true;
                          notifyListeners();
                         userChooseTime = cinema[cindex].timeslots?[index].startTime;
                         notifyListeners();
                     userChooseCinema = cinema[cindex].cinema;
                       userChoosedayTimeslotId = cinema[cindex].timeslots?[index].cinemaDayTimeslotId;
                         cinemaId = cinema[cindex].cinemaId;
                         cinemaInfo = cinema;
                         notifyListeners();
                         return cinemaInfo;
                         print(cinemaInfo?[2].timeslots?[2].isSelected);                        
                                  }
    

    //      void userChooseTimeAction(int cindex,int index,String getDate){
    //                movieModel.getCinemaDayTimeslotDatabase(getDate.split(" ")[0]).listen((value) {
    //       print("Get Cinema DayTimeslot with new date in view layer ==============> ${value?.cinemaList}");
    //        value?.cinemaList?.forEach((outer) {
    //                               outer.timeslots?.forEach((inner) {
    //                                    inner.isSelected = false;
    //                              });
    //                       });
    //        value?.cinemaList?[cindex].timeslots?[index].isSelected = true;
    //         userChooseTime = value?.cinemaList?[cindex].timeslots?[index].startTime;
    //                 userChooseCinema = value?.cinemaList?[cindex].cinema;
    //                 userChoosedayTimeslotId = value?.cinemaList?[cindex].timeslots?[index].cinemaDayTimeslotId;
    //                    cinemaId = value?.cinemaList?[cindex].cinemaId;
    //       cinemaInfo = value?.cinemaList;
    //       dateData = getDate.split(" ")[0];
    //       notifyListeners();
    //   });     
    //        notifyListeners();               
    //  }



}