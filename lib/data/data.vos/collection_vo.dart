import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_COLLECTION_VO,adapterName: "CollectionVOAdapter")
class CollectionVO{
  @JsonKey(name: "id")
  @HiveField(0)
    int? id;

  @JsonKey(name: "name")
  @HiveField(1)
    String? name;

  @JsonKey(name: "poster_path")
  @HiveField(2)
    String? posterPath;

  @JsonKey(name: "backdrop_path")
  @HiveField(3)
    String? backdropPath;

  CollectionVO(this.id, this.name, this.posterPath, this.backdropPath);

  factory CollectionVO.fromJson(Map<String,dynamic> json) => _$CollectionVOFromJson(json);

  Map<String,dynamic> toJson() => _$CollectionVOToJson(this);
}