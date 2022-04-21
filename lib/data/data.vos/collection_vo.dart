import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

part 'collection_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_COLLECTION_VO,adapterName: "CollectionVOAdapter")
class CollectionVO {
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CollectionVO &&
      other.id == id &&
      other.name == name &&
      other.posterPath == posterPath &&
      other.backdropPath == backdropPath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      posterPath.hashCode ^
      backdropPath.hashCode;
  }
}
