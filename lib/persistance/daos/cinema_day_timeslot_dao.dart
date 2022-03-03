import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinema_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinemalist_for_hive_vo.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

class CinemaDayTimeslotDao{

  static final CinemaDayTimeslotDao _singleton = CinemaDayTimeslotDao._internal();

  factory CinemaDayTimeslotDao(){
    return _singleton;
  }

  CinemaDayTimeslotDao._internal();

  void saveAllCinemaDayTimeslot(String date,CinemaListForHiveVO cinmea)async{
    return getCinmeaBox().put(date,cinmea);
  }

  CinemaListForHiveVO? getAllCinemaDayTimeslot(String date){
    return getCinmeaBox().get(date);
  }

  ///Reactive Programming
  
  Stream<void> getAllCinemaDaytimeslotEventStream(){
    return getCinmeaBox().watch();
  }

  CinemaListForHiveVO? getCinemaDayTimeslotStream(String date){
      if(getAllCinemaDayTimeslot(date) != null){
        print("Cinema Daytime slot in database ==========================> ${getAllCinemaDayTimeslot(date)}");
          return getAllCinemaDayTimeslot(date);
      }else{
        return CinemaListForHiveVO.emptySituation();
      }
  }
  

  Box<CinemaListForHiveVO> getCinmeaBox(){
    return Hive.box<CinemaListForHiveVO>(BOX_NAME_CINEMA_VO);
  }
}