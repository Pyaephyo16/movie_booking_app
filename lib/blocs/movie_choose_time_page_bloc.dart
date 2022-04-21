import 'package:flutter/foundation.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinema_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/timeslot_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
import 'package:collection/collection.dart';

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


MovieChooseTimePageBloc(String startDate,{MovieModel? mModel}){

  if(mModel != null){
    movieModel = mModel;
  }

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
        List<CinemaVO>? newActionCinemaList = cinemaInfo?.mapIndexed((i,outer){
                  outer.timeslots?.mapIndexed((j,inner){
                      inner.isSelected = false;
                      if(i == cindex && j == index){
                        inner.isSelected = true;
                      }
                      return inner;
                  }).toList();
                  return outer;
              }).toList();
              cinemaInfo = newActionCinemaList;
              notifyListeners();
                         userChooseTime = cinemaInfo?[cindex].timeslots?[index].startTime;
                         notifyListeners();
                     userChooseCinema = cinemaInfo?[cindex].cinema;
                       userChoosedayTimeslotId = cinemaInfo?[cindex].timeslots?[index].cinemaDayTimeslotId;
                         cinemaId = cinemaInfo?[cindex].cinemaId;
                         notifyListeners();                      
      }
    

}