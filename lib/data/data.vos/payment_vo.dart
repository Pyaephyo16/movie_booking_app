import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

part 'payment_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_PAYMENT_METHOD_VO,adapterName: "PaymentMethodVOAdapter")
class PaymentVO {

  @JsonKey(name: "id")
  @HiveField(0)
    int? id;

  @JsonKey(name: "name")
  @HiveField(1)
    String? name;

    @JsonKey(name: "description")
    @HiveField(2)
    String? description;

    @HiveField(3)
    bool? isSelected;


  PaymentVO(this.id, this.name, this.description, this.isSelected);

  factory PaymentVO.fromJson(Map<String,dynamic> json) => _$PaymentVOFromJson(json);

  Map<String,dynamic> toJson() => _$PaymentVOToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PaymentVO &&
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      isSelected.hashCode;
  }
}
