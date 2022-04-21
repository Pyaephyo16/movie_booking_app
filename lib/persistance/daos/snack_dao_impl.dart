import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/persistance/abstraction_layer/snack_dao.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

class SnackDaoImpl extends SnackDao{

  static final SnackDaoImpl _singleton = SnackDaoImpl._internal();

  factory SnackDaoImpl(){
    return _singleton;
  }

  SnackDaoImpl._internal();

  @override
  void saveAllSnacks(List<SnackVO> snackList)async{
    Map<int,SnackVO> getSnackMap = Map.fromIterable(
      snackList,
      key: (snack) => snack.id,
      value: (snack) => snack,
    );
    return getSnackBox().putAll(getSnackMap);
  }

  @override
  List<SnackVO> getAllSnacks(){
    return getSnackBox().values.toList();
  }


  ///Reactive Programming

  @override
  Stream<void> getAllSnacksEventStream(){
      return getSnackBox().watch();
  }

  @override
  List<SnackVO> getAllSnacksData(){
    if(getAllSnacks() != null && getAllSnacks().isNotEmpty){
      print("All Snacks in database====================> ${getAllSnacks()}");
      return getAllSnacks();
    }else{
      return [];
    }
  }

  @override
  Stream<List<SnackVO>> getAllSnacksStream(){
      return Stream.value(getAllSnacks());
  }


  Box<SnackVO> getSnackBox(){
    return Hive.box<SnackVO>(BOX_NAME_SNACK_VO);
  }
}