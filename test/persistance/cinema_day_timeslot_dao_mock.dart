import 'package:hw3_movie_booking_app/data/data.vos/cinemalist_for_hive_vo.dart';
import 'package:hw3_movie_booking_app/persistance/abstraction_layer/cinema_day_timeslot_dao.dart';

import '../mock_data/mock_data.dart';

class CinemaDayTimeslotDaoMock extends CinemaDayTimeslotDao{

  Map<String,CinemaListForHiveVO> cinemaDatabaseMock = {};

  @override
  CinemaListForHiveVO? getAllCinemaDayTimeslot(String date) {
    return cinemaToDatabaseMock();
  }

  @override
  Stream<void> getAllCinemaDaytimeslotEventStream() {
    return Stream<void>.value(null);
  }

  @override
  CinemaListForHiveVO? getCinemaDayTimeslot(String date) {
    if(cinemaToDatabaseMock() != null){
      print("In database cinme to databackMock check ==============> ${cinemaToDatabaseMock()}");
       return cinemaToDatabaseMock();
    }
  }

  @override
  Stream<CinemaListForHiveVO?> getCinemaDayTimeslotStream(String date) {
    return Stream.value(
      cinemaToDatabaseMock(),
    );
  }

  @override
  void saveAllCinemaDayTimeslot(String date, CinemaListForHiveVO cinmea) {
    cinemaDatabaseMock[date] = cinmea;
  }

  

}