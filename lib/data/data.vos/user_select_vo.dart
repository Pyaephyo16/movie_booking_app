import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/timeslot_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_select_vo.g.dart';

@JsonSerializable()
class UserSelectVO{

  @JsonKey(name: "id")
    int? id;

  @JsonKey(name: "booking_no")
    String? bookingNo;

  @JsonKey(name: "booking_date")
    String? bookingDate;

  @JsonKey(name: "row")
    String? row;

  @JsonKey(name: "seat")
    String? seat;

  @JsonKey(name: "total_seat")
    int? totalSeat;

  @JsonKey(name: "total")
    String? total;

  @JsonKey(name: "movie_id")
    int? movieId;

  @JsonKey(name: "cinema_id")
    int? cinemaId;

  @JsonKey(name: "username")
    String? userName;

  @JsonKey(name: "timeslot")
    TimeslotVO? timeslot;

  @JsonKey(name: "snacks")
    List<SnackVO>? snacks;

  UserSelectVO.start();


  UserSelectVO(
      this.id,
      this.bookingNo,
      this.bookingDate,
      this.row,
      this.seat,
      this.totalSeat,
      this.total,
      this.movieId,
      this.cinemaId,
      this.userName,
      this.timeslot,
      this.snacks);

  factory UserSelectVO.fromJson(Map<String,dynamic> json) => _$UserSelectVOFromJson(json);

  Map<String,dynamic> toJson() => _$UserSelectVOToJson(this);
}