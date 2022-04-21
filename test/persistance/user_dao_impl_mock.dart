import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/persistance/abstraction_layer/user_dao.dart';

import '../mock_data/mock_data.dart';

class UserDaoImplMock extends UserDao{

  Map<int,UserVO> userInfoDatabaseMock = {};

  @override
  deleteUserInfo() {
   //no need 
  }

  @override
  List<UserVO> getUserInfo() {
    return [profileMockForTest()];
  }

  @override
  List<UserVO> getUserInfoData() {
      return [profileMockForTest()];
  }

  @override
  Stream<void> getUserInfoEventStream() {
    return Stream<void>.value(null);
  }

  @override
  Stream<List<UserVO>> getUserInfoStream() {
    return Stream.value(
      [profileMockForTest()],
    );
  }

  @override
  Future<void> saveUserInfoFuture(UserVO userInfo) {
     return Future.value(userInfoDatabaseMock[userInfo.id!] = userInfo); 
  }



}