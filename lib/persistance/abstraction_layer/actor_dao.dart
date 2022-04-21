import 'package:hw3_movie_booking_app/data/data.vos/actorlist_for_hive_vo.dart';

abstract class ActorDao{

  void saveAllActors(int movieId,ActorListForHiveVO actorList);
  ActorListForHiveVO? getAllActors(int movieId);

  Stream<void> getActorEventStream();
  ActorListForHiveVO? getAllActorsData(int movieId);
  Stream<ActorListForHiveVO?> getAllActorsStream(int movieId);

}