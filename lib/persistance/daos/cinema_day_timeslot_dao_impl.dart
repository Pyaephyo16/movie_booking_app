import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinema_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinemalist_for_hive_vo.dart';
import 'package:hw3_movie_booking_app/persistance/abstraction_layer/cinema_day_timeslot_dao.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

class CinemaDayTimeslotDaoImpl extends CinemaDayTimeslotDao{

  static final CinemaDayTimeslotDaoImpl _singleton = CinemaDayTimeslotDaoImpl._internal();

  factory CinemaDayTimeslotDaoImpl(){
    return _singleton;
  }

  CinemaDayTimeslotDaoImpl._internal();

  @override
  void saveAllCinemaDayTimeslot(String date,CinemaListForHiveVO cinmea)async{
    return getCinmeaBox().put(date,cinmea);
  }

  @override
  CinemaListForHiveVO? getAllCinemaDayTimeslot(String date){
    return getCinmeaBox().get(date);
  }

  ///Reactive Programming
  
    @override
  Stream<void> getAllCinemaDaytimeslotEventStream(){
    return getCinmeaBox().watch();
  }

  @override
  CinemaListForHiveVO? getCinemaDayTimeslot(String date){
      if(getAllCinemaDayTimeslot(date) != null){
        print("Cinema Daytime slot in database ==========================> ${getAllCinemaDayTimeslot(date)}");
          return getAllCinemaDayTimeslot(date);
      }else{
        return CinemaListForHiveVO.emptySituation();
      }
  }

  @override
   Stream<CinemaListForHiveVO?> getCinemaDayTimeslotStream(String date){
          return Stream.value(getAllCinemaDayTimeslot(date));
  }
  

  Box<CinemaListForHiveVO> getCinmeaBox(){
    return Hive.box<CinemaListForHiveVO>(BOX_NAME_CINEMA_VO);
  }
}