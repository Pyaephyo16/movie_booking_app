import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/data/data.vos/card_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

class UserDao{

  static final UserDao _singleton = UserDao._internal();

  factory UserDao(){
    return _singleton;
  }

UserDao._internal();

  void saveUserInfo(UserVO userInfo)async{
        return getUserBox().put(userInfo.id, userInfo);
  }


  List<UserVO> getUserInfo(){
    return getUserBox().values.toList();
  }

     deleteUserInfo(){
       return getUserBox().clear();
  }

  ///Reactive Programming
  
  Stream<void> getUserInfoEventStream(){
    return getUserBox().watch();
  }

  List<UserVO> getUserInfoStream(){
      if(getUserInfo() != null && getUserInfo().isNotEmpty){
        print("Persistance layer data output check =========> ${getUserInfo()}");
        return getUserInfo();
      }else{
        return [];
      }
  }


  Box<UserVO> getUserBox(){
    return Hive.box<UserVO>(BOX_NAME_USER_VO);
  }
}