import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinema_vo.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cinemalist_for_hive_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CINEMALIST_FOR_HIVE_VO,adapterName: "CinemaListForHiveVOAdapter")
class CinemaListForHiveVO{

  @HiveField(0)
  List<CinemaVO>? cinemaList;

  CinemaListForHiveVO(this.cinemaList);

  factory CinemaListForHiveVO.fromJson(Map<String,dynamic> json) => _$CinemaListForHiveVOFromJson(json);

  Map<String,dynamic> toJson() => _$CinemaListForHiveVOToJson(this);

  @override
  String toString() {
    return 'CinemaListForHiveVO{cinemaList: $cinemaList}';
  }
}