import 'package:json_annotation/json_annotation.dart';

part 'seat_vo.g.dart';

@JsonSerializable()
class SeatVO{

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
}