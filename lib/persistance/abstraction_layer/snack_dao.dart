import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';

abstract class SnackDao{

    void saveAllSnacks(List<SnackVO> snackList);
    List<SnackVO> getAllSnacks();
    
    Stream<void> getAllSnacksEventStream();
    List<SnackVO> getAllSnacksData();
    Stream<List<SnackVO>> getAllSnacksStream();

}