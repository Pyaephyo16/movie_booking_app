import 'package:hw3_movie_booking_app/data/data.vos/user_select_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_checkout_response.g.dart';

@JsonSerializable()
class PostCheckoutResponse{

  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  UserSelectVO? data;

  PostCheckoutResponse(this.code, this.message, this.data);

  factory PostCheckoutResponse.fromJson(Map<String,dynamic> json) => _$PostCheckoutResponseFromJson(json);

  Map<String,dynamic> toJson() => _$PostCheckoutResponseToJson(this);
}