import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/persistance/abstraction_layer/snack_dao.dart';

import '../mock_data/mock_data.dart';

class SnackDaoImplMock extends SnackDao{

Map<int,SnackVO> snackDatabaseMock = {};

  @override
  List<SnackVO> getAllSnacks() {
    return snacksMockForTest();
  }

  @override
  List<SnackVO> getAllSnacksData() {
    if(snacksMockForTest() != null && snacksMockForTest().isNotEmpty){
      return snacksMockForTest();
    }else{
     return [];
   }
  }

  @override
  Stream<void> getAllSnacksEventStream() {
    return Stream<void>.value(null);
  }

  @override
  Stream<List<SnackVO>> getAllSnacksStream() {
    return Stream.value(
      snacksMockForTest(),
    );
  }

  @override
  void saveAllSnacks(List<SnackVO> snackList) {
      snackList.forEach((element) {
        snackDatabaseMock[element.id!] = element;
      });
  }

  

}