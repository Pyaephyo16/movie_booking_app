import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';
import 'package:json_annotation/json_annotation.dart';


part 'card_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CARD_VO,adapterName: "CardVOAdapter")
class CardVO{
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "card_holder")
  @HiveField(1)
  String? cardHolder;

  @JsonKey(name: "card_number")
  @HiveField(2)
  String? cardNumber;

  @JsonKey(name: "expiration_date")
  @HiveField(3)
  String? expirationDate;

  @JsonKey(name: "card_type")
  @HiveField(4)
  String? cardType;

  //CardVO.empytSituation();

  CardVO(this.id, this.cardHolder, this.cardNumber, this.expirationDate,
      this.cardType);

  factory CardVO.fromJson(Map<String,dynamic> json) => _$CardVOFromJson(json);

  Map<String,dynamic> toJson()=> _$CardVOToJson(this);
}