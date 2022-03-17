import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/data/data.vos/card_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

class CardsFromProfileDao{

  static final CardsFromProfileDao _singleton = CardsFromProfileDao._internal();

  factory CardsFromProfileDao(){
    return _singleton;
  }

  CardsFromProfileDao._internal();

  void getCardsFromProfileDatabase(UserVO userData)async{
        getCardBox().put(userData.token,userData);
  }

  UserVO? getAllCards(String tokenData){
    return getCardBox().get(tokenData);
  }


   deleteAllCards(){
    getCardBox().clear();
  }


///Reactive Programming


Stream<void> getAllCardsEventStream(){
  return getCardBox().watch();
}

UserVO? getAllCardsData(String tokenData){
  if(getAllCards(tokenData) != null){
      print("All cards in database ===========================> ${getAllCards(tokenData)}");
    return getAllCards(tokenData);
  }else{
    return UserVO.emptySituation();
  }
}

Stream<UserVO?> getAllCardsStream(String tokenData){
    return Stream.value(getAllCards(tokenData));
}

  Box<UserVO> getCardBox(){
    return Hive.box<UserVO>(BOX_NAME_CARD_VO);
  }

}