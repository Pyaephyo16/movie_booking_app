import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/data/data.vos/card_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/persistance/abstraction_layer/user_dao.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

class UserDaoImpl extends UserDao{

  static final UserDaoImpl _singleton = UserDaoImpl._internal();

  factory UserDaoImpl(){
    return _singleton;
  }

UserDaoImpl._internal();

  // void saveUserInfo(UserVO userInfo)async{
  //       return getUserBox().put(userInfo.id, userInfo);
  // }

  @override
  Future<void> saveUserInfoFuture(UserVO userInfo){
      return getUserBox().put(userInfo.id, userInfo);
  }

  @override
  List<UserVO> getUserInfo(){
    return getUserBox().values.toList();
  }

  @override
     deleteUserInfo(){
       return getUserBox().clear();
  }

  ///Reactive Programming
  
    @override
  Stream<void> getUserInfoEventStream(){
    return getUserBox().watch();
  }

  @override
  List<UserVO> getUserInfoData(){
      if(getUserInfo() != null && getUserInfo().isNotEmpty){
        print("Persistance layer data output check =========> ${getUserInfo()}");
        return getUserInfo();
      }else{
        return [];
      }
  }

  @override
   Stream<List<UserVO>> getUserInfoStream(){
        return Stream.value(getUserInfo());
  }


  Box<UserVO> getUserBox(){
    return Hive.box<UserVO>(BOX_NAME_USER_VO);
  }
}