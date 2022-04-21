import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';

abstract class CardsFromProfileDao{

  void getCardsFromProfileDatabase(UserVO userData);
  UserVO? getAllCards(String tokenData);

  Stream<void> getAllCardsEventStream();
  UserVO? getAllCardsData(String tokenData);
  Stream<UserVO?> getAllCardsStream(String tokenData);

}