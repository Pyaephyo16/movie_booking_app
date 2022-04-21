import 'package:hw3_movie_booking_app/data/data.vos/actor_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/actorlist_for_hive_vo.dart';
import 'package:hw3_movie_booking_app/persistance/abstraction_layer/actor_dao.dart';

import '../mock_data/mock_data.dart';

class ActorDaoImplMock extends ActorDao{


  Map<int,ActorListForHiveVO> getActorDatabaseMock = {};

  @override
  Stream<void> getActorEventStream() {
    return Stream<void>.value(null);
  }

  @override
  ActorListForHiveVO? getAllActors(int movieId) {
    return actorToDatabaseMock();
  }

  @override
  ActorListForHiveVO? getAllActorsData(int movieId) {
    if(actorToDatabaseMock() != null){
      return actorToDatabaseMock();
    }
  }

  @override
  Stream<ActorListForHiveVO?> getAllActorsStream(int movieId) {
   return Stream.value(
     actorToDatabaseMock(),
   );
  }

  @override
  void saveAllActors(int movieId, ActorListForHiveVO actorList) {
    getActorDatabaseMock[movieId] = actorList;
  }



}