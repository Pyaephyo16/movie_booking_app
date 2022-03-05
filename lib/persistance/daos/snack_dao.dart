import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

class SnackDao{

  static final SnackDao _singleton = SnackDao._internal();

  factory SnackDao(){
    return _singleton;
  }

  SnackDao._internal();


  void saveAllSnacks(List<SnackVO> snackList)async{
    Map<int,SnackVO> getSnackMap = Map.fromIterable(
      snackList,
      key: (snack) => snack.id,
      value: (snack) => snack,
    );
    return getSnackBox().putAll(getSnackMap);
  }

  List<SnackVO> getAllSnacks(){
    return getSnackBox().values.toList();
  }


  ///Reactive Programming

  Stream<void> getAllSnacksEventStream(){
      return getSnackBox().watch();
  }

  List<SnackVO> getAllSnacksData(){
    if(getAllSnacks() != null && getAllSnacks().isNotEmpty){
      print("All Snacks in database====================> ${getAllSnacks()}");
      return getAllSnacks();
    }else{
      return [];
    }
  }

  Stream<List<SnackVO>> getAllSnacksStream(){
      return Stream.value(getAllSnacks());
  }


  Box<SnackVO> getSnackBox(){
    return Hive.box<SnackVO>(BOX_NAME_SNACK_VO);
  }
}