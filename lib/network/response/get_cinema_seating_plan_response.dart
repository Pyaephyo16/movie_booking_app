import 'package:hw3_movie_booking_app/data/data.vos/seat_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_cinema_seating_plan_response.g.dart';

@JsonSerializable()
class GetCinemaSeatingPlanResponse{

  @JsonKey(name: "code")
    int? code;

  @JsonKey(name: "message")
    String? message;

  @JsonKey(name: "data")
    List<List<SeatVO>>? data;


  GetCinemaSeatingPlanResponse(this.code, this.message, this.data);

  factory GetCinemaSeatingPlanResponse.fromJson(Map<String,dynamic> json) => _$GetCinemaSeatingPlanResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetCinemaSeatingPlanResponseToJson(this);
}