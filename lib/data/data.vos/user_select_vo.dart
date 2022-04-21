import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/timeslot_vo.dart';

part 'user_select_vo.g.dart';

@JsonSerializable()
class UserSelectVO {

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

UserSelectVO.emptySituation();

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

  @override
  String toString() {
    return 'UserSelectVO(id: $id, bookingNo: $bookingNo, bookingDate: $bookingDate, row: $row, seat: $seat, totalSeat: $totalSeat, total: $total, movieId: $movieId, cinemaId: $cinemaId, userName: $userName, timeslot: $timeslot, snacks: $snacks)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserSelectVO &&
      other.id == id &&
      other.bookingNo == bookingNo &&
      other.bookingDate == bookingDate &&
      other.row == row &&
      other.seat == seat &&
      other.totalSeat == totalSeat &&
      other.total == total &&
      other.movieId == movieId &&
      other.cinemaId == cinemaId &&
      other.userName == userName &&
      other.timeslot == timeslot &&
      listEquals(other.snacks, snacks);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      bookingNo.hashCode ^
      bookingDate.hashCode ^
      row.hashCode ^
      seat.hashCode ^
      totalSeat.hashCode ^
      total.hashCode ^
      movieId.hashCode ^
      cinemaId.hashCode ^
      userName.hashCode ^
      timeslot.hashCode ^
      snacks.hashCode;
  }
}
