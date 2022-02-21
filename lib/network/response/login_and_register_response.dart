import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_and_register_response.g.dart';

@JsonSerializable()
class LoginAndRegisterResponse{

  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  UserVO? data;

  @JsonKey(name: "token")
  String? token;


  LoginAndRegisterResponse(this.code, this.message, this.data, this.token);

  factory LoginAndRegisterResponse.fromJson(Map<String,dynamic> json) => _$LoginAndRegisterResponseFromJson(json);

  Map<String,dynamic> toJson() => _$LoginAndRegisterResponseToJson(this);
}