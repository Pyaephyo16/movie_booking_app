import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/data/data.vos/card_vo.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

class CardsFromProfileDao{

  static final CardsFromProfileDao _singleton = CardsFromProfileDao._internal();

  factory CardsFromProfileDao(){
    return _singleton;
  }

  CardsFromProfileDao._internal();

  void getCardsFromProfileDatabase(List<CardVO> cards)async{
      Map<int,CardVO> getCardMap = Map.fromIterable(
        cards,
        key: (card) => card.id,
        value: (card) => card,
      );
    await getCardBox().putAll(getCardMap);
  }

  List<CardVO> getAllCards(){
    return getCardBox().values.toList();
  }



  Box<CardVO> getCardBox(){
    return Hive.box<CardVO>(BOX_NAME_CARD_VO);
  }

}