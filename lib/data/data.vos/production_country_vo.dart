import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'production_country_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_PRODUCTION_COUNTRY_VO,adapterName: "ProductionCountryVOAdapter")
class ProductionCountryVO{
  @JsonKey(name: "iso_3166_1")
  @HiveField(0)
    String? iso31661;

  @JsonKey(name: "name")
  @HiveField(1)
    String? name;

  ProductionCountryVO(this.iso31661, this.name);

  factory ProductionCountryVO.fromJson(Map<String,dynamic> json) => _$ProductionCountryVOFromJson(json);

  Map<String,dynamic> toJson() => _$ProductionCountryVOToJson(this);
}