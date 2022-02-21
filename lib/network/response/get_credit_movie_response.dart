import 'package:hw3_movie_booking_app/data/data.vos/actor_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_credit_movie_response.g.dart';

@JsonSerializable()
class GetCreditMovieResponse{
  @JsonKey(name: "id")
    int? id;

  @JsonKey(name: "cast")
    List<ActorVO>? cast;

  @JsonKey(name: "crew")
    List<ActorVO>? crew;


  GetCreditMovieResponse(this.id, this.cast, this.crew);

  factory GetCreditMovieResponse.fromJson(Map<String,dynamic> json) => _$GetCreditMovieResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetCreditMovieResponseToJson(this);
}