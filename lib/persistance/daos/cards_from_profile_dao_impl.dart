import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/data/data.vos/card_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/persistance/abstraction_layer/cards_from_profile_dao.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

class CardsFromProfileDaoImpl extends CardsFromProfileDao{

  static final CardsFromProfileDaoImpl _singleton = CardsFromProfileDaoImpl._internal();

  factory CardsFromProfileDaoImpl(){
    return _singleton;
  }

  CardsFromProfileDaoImpl._internal();

  @override
  void getCardsFromProfileDatabase(UserVO userData)async{
        getCardBox().put(userData.token,userData);
  }


@override
  UserVO? getAllCards(String tokenData){
    return getCardBox().get(tokenData);
  }

   deleteAllCards(){
    getCardBox().clear();
  }


///Reactive Programming

@override
Stream<void> getAllCardsEventStream(){
  return getCardBox().watch();
}


@override
UserVO? getAllCardsData(String tokenData){
  if(getAllCards(tokenData) != null){
      print("All cards in database ===========================> ${getAllCards(tokenData)}");
    return getAllCards(tokenData);
  }else{
    return UserVO.emptySituation();
  }
}

@override
Stream<UserVO?> getAllCardsStream(String tokenData){
    return Stream.value(getAllCards(tokenData));
}

  Box<UserVO> getCardBox(){
    return Hive.box<UserVO>(BOX_NAME_CARD_VO);
  }

}