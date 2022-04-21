import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

part 'actor_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_ACTOR_VO,adapterName: "ActorVOAdapter")
class ActorVO {
  @JsonKey(name: "adult")
  @HiveField(0)
    bool? adult;

  @JsonKey(name: "gender")
  @HiveField(1)
    int? gender;

  @JsonKey(name: "id")
  @HiveField(2)
    int? id;

  @JsonKey(name: "known_for_department")
  @HiveField(3)
    String? knownForDepartment;

  @JsonKey(name: "name")
  @HiveField(4)
    String? name;

  @JsonKey(name: "original_name")
  @HiveField(5)
    String? originalName;

  @JsonKey(name: "popularity")
  @HiveField(6)
    double? popularity;

  @JsonKey(name: "profile_path")
  @HiveField(7)
    String? profilePath;

  @JsonKey(name: "cast_id")
  @HiveField(8)
    int? castId;

  @JsonKey(name: "character")
  @HiveField(9)
    String? character;

   @JsonKey(name: "credit_id")
   @HiveField(10)
    String? creditId;

   @JsonKey(name: "order")
   @HiveField(11)
    int? order;

    @JsonKey(name: "department")
    @HiveField(12)
    String? department;

    @JsonKey(name: "job")
    @HiveField(13)
    String? job;


  ActorVO(
      this.adult,
      this.gender,
      this.id,
      this.knownForDepartment,
      this.name,
      this.originalName,
      this.popularity,
      this.profilePath,
      this.castId,
      this.character,
      this.creditId,
      this.order,
      this.department,
      this.job);

  factory ActorVO.fromJson(Map<String,dynamic> json) => _$ActorVOFromJson(json);

  Map<String,dynamic> toJson() => _$ActorVOToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ActorVO &&
      other.adult == adult &&
      other.gender == gender &&
      other.id == id &&
      other.knownForDepartment == knownForDepartment &&
      other.name == name &&
      other.originalName == originalName &&
      other.popularity == popularity &&
      other.profilePath == profilePath &&
      other.castId == castId &&
      other.character == character &&
      other.creditId == creditId &&
      other.order == order &&
      other.department == department &&
      other.job == job;
  }

  @override
  int get hashCode {
    return adult.hashCode ^
      gender.hashCode ^
      id.hashCode ^
      knownForDepartment.hashCode ^
      name.hashCode ^
      originalName.hashCode ^
      popularity.hashCode ^
      profilePath.hashCode ^
      castId.hashCode ^
      character.hashCode ^
      creditId.hashCode ^
      order.hashCode ^
      department.hashCode ^
      job.hashCode;
  }

  @override
  String toString() {
    return 'ActorVO(adult: $adult, gender: $gender, id: $id, knownForDepartment: $knownForDepartment, name: $name, originalName: $originalName, popularity: $popularity, profilePath: $profilePath, castId: $castId, character: $character, creditId: $creditId, order: $order, department: $department, job: $job)';
  }
}
