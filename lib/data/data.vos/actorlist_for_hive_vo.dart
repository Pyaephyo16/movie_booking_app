import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hw3_movie_booking_app/data/data.vos/actor_vo.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

part 'actorlist_for_hive_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_ACTORLIST_FOR_HIVE_VO,adapterName: "ActorListForHiveVOAdapter")
class ActorListForHiveVO {

  @HiveField(0)
  List<ActorVO>? actorList;

  ActorListForHiveVO.emptySituation();

  ActorListForHiveVO(this.actorList);

  factory ActorListForHiveVO.fromJson(Map<String,dynamic> json) => _$ActorListForHiveVOFromJson(json);

  Map<String,dynamic> toJson() => _$ActorListForHiveVOToJson(this);

  @override
  String toString() {
    return 'ActorListForHiveVO{actorList: $actorList}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ActorListForHiveVO &&
      listEquals(other.actorList, actorList);
  }

  @override
  int get hashCode => actorList.hashCode;
}
