import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/data/data.vos/actor_vo.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'actorlist_for_hive_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_ACTORLIST_FOR_HIVE_VO,adapterName: "ActorListForHiveVOAdapter")
class ActorListForHiveVO{

  @HiveField(0)
  List<ActorVO>? actorList;

  ActorListForHiveVO(this.actorList);

  factory ActorListForHiveVO.fromJson(Map<String,dynamic> json) => _$ActorListForHiveVOFromJson(json);

  Map<String,dynamic> toJson() => _$ActorListForHiveVOToJson(this);

  @override
  String toString() {
    return 'ActorListForHiveVO{actorList: $actorList}';
  }
}