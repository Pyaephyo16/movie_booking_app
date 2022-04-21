import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hw3_movie_booking_app/data/data.vos/cinema_vo.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

part 'cinemalist_for_hive_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CINEMALIST_FOR_HIVE_VO,adapterName: "CinemaListForHiveVOAdapter")
class CinemaListForHiveVO {

  @HiveField(0)
  List<CinemaVO>? cinemaList;


  CinemaListForHiveVO.emptySituation();

  CinemaListForHiveVO(this.cinemaList);

  factory CinemaListForHiveVO.fromJson(Map<String,dynamic> json) => _$CinemaListForHiveVOFromJson(json);

  Map<String,dynamic> toJson() => _$CinemaListForHiveVOToJson(this);

  @override
  String toString() => 'CinemaListForHiveVO(cinemaList: $cinemaList)';



  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CinemaListForHiveVO &&
      listEquals(other.cinemaList, cinemaList);
  }

  @override
  int get hashCode => cinemaList.hashCode;
}
