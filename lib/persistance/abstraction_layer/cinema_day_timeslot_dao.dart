import 'package:hw3_movie_booking_app/data/data.vos/cinemalist_for_hive_vo.dart';

abstract class CinemaDayTimeslotDao{

void saveAllCinemaDayTimeslot(String date,CinemaListForHiveVO cinmea);
CinemaListForHiveVO? getAllCinemaDayTimeslot(String date);

Stream<void> getAllCinemaDaytimeslotEventStream();
CinemaListForHiveVO? getCinemaDayTimeslot(String date);
Stream<CinemaListForHiveVO?> getCinemaDayTimeslotStream(String date);

}