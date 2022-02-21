import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_snack_list_response.g.dart';

@JsonSerializable()
class GetSnackListResponse{

  @JsonKey(name: "code")
    int? code;

  @JsonKey(name: "message")
    String? message;

  @JsonKey(name: "data")
    List<SnackVO>? data;

  GetSnackListResponse(this.code, this.message, this.data);

  factory GetSnackListResponse.fromJson(Map<String,dynamic> json) => _$GetSnackListResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetSnackListResponseToJson(this);
}