import 'package:json_annotation/json_annotation.dart';

part 'seat_vo.g.dart';

@JsonSerializable()
class SeatVO {

  @JsonKey(name: "id")
    int? id;

  @JsonKey(name: "type")
    String? type;

  @JsonKey(name: "seat_name")
    String? seatName;

  @JsonKey(name: "symbol")
    String? symbol;

  @JsonKey(name: "price")
    int? price;

    bool? isSelected;

  SeatVO(this.id, this.type, this.seatName, this.symbol, this.price,
      this.isSelected);

  factory SeatVO.fromJson(Map<String,dynamic> json) => _$SeatVOFromJson(json);

  Map<String,dynamic> toJson() => _$SeatVOToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SeatVO &&
      other.id == id &&
      other.type == type &&
      other.seatName == seatName &&
      other.symbol == symbol &&
      other.price == price &&
      other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      type.hashCode ^
      seatName.hashCode ^
      symbol.hashCode ^
      price.hashCode ^
      isSelected.hashCode;
  }
}
