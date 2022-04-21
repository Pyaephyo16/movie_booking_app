import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';

abstract class UserDao{

  Future<void> saveUserInfoFuture(UserVO userInfo);
  List<UserVO> getUserInfo();
   deleteUserInfo();

   Stream<void> getUserInfoEventStream();
    List<UserVO> getUserInfoData();
    Stream<List<UserVO>> getUserInfoStream();

}