import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/data/data.vos/actor_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/actorlist_for_hive_vo.dart';
import 'package:hw3_movie_booking_app/persistance/abstraction_layer/actor_dao.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

class ActorDaoImpl extends ActorDao{

  static final ActorDaoImpl _singleton = ActorDaoImpl._internal();

  factory ActorDaoImpl(){
    return _singleton;
  }

  ActorDaoImpl._internal();

  @override
  void saveAllActors(int movieId,ActorListForHiveVO actorList)async{
    return getActorBox().put(movieId,actorList);
  }

  @override
 ActorListForHiveVO? getAllActors(int movieId){
    return getActorBox().get(movieId);
  }


  ///Reactive Programming
  
  @override
  Stream<void> getActorEventStream(){
    return getActorBox().watch();
  }

  @override
  ActorListForHiveVO? getAllActorsData(int movieId){
      if(getAllActors(movieId) != null ){
        print("Actor list in database ==========> ${getAllActors(movieId)}");
        return getAllActors(movieId);
      }else{
        return ActorListForHiveVO.emptySituation();
      }
  }

  @override
  Stream<ActorListForHiveVO?> getAllActorsStream(int movieId){
        return Stream.value(getAllActors(movieId));
  }

  Box<ActorListForHiveVO> getActorBox(){
    return Hive.box<ActorListForHiveVO>(BOX_NAME_ACTOR_VO);
  }
}