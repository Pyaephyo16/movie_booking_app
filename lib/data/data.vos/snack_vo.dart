import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

part 'snack_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SNACK_VO,adapterName: "SnackVOAdapter")
class SnackVO {

  @JsonKey(name: "id")
  @HiveField(0)
    int? id;

  @JsonKey(name: "name")
  @HiveField(1)
    String? name;

  @JsonKey(name: "description")
  @HiveField(2)
    String? description;

  @JsonKey(name: "price")
  @HiveField(3)
    int? price;

  @JsonKey(name: "image")
  @HiveField(4)
    String? image;

  @HiveField(5)
  int? quantity;


  SnackVO(this.id, this.name, this.description, this.price, this.image,
      this.quantity);

  factory SnackVO.fromJson(Map<String,dynamic> json) => _$SnackVOFromJson(json);

  Map<String,dynamic> toJson() => _$SnackVOToJson(this);

  @override
  String toString() {
    return 'SnackVO{id: $id, name: $name, description: $description, price: $price, image: $image, quantity: $quantity}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SnackVO &&
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.price == price &&
      other.image == image &&
      other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      image.hashCode ^
      quantity.hashCode;
  }
}
