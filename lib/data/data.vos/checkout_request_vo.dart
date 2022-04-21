import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';

part 'checkout_request_vo.g.dart';

@JsonSerializable()
class CheckoutRequestVO {

  @JsonKey(name: "cinema_day_timeslot_id")
    int? cinemaDayTimeslotId;

  @JsonKey(name: "row")
  String? row;

  @JsonKey(name: "seat_number")
  String? seatNumber;

  @JsonKey(name: "booking_date")
  String? bookingDate;

  @JsonKey(name: "total_price")
  int? totalPrice;

  @JsonKey(name: "movie_id")
  int? movieId;

  @JsonKey(name: "card_id")
  int? cardId;

  @JsonKey(name: "cinema_id")
  int? cinemaId;

  @JsonKey(name: "snacks")
  List<SnackVO>? snacks;

  CheckoutRequestVO.emptySituation();

  CheckoutRequestVO(
      this.cinemaDayTimeslotId,
      this.row,
      this.seatNumber,
      this.bookingDate,
      this.totalPrice,
      this.movieId,
      this.cardId,
      this.cinemaId,
      this.snacks);

  factory CheckoutRequestVO.fromJson(Map<String,dynamic> json) => _$CheckoutRequestVOFromJson(json);

  Map<String,dynamic> toJson() => _$CheckoutRequestVOToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CheckoutRequestVO &&
      other.cinemaDayTimeslotId == cinemaDayTimeslotId &&
      other.row == row &&
      other.seatNumber == seatNumber &&
      other.bookingDate == bookingDate &&
      other.totalPrice == totalPrice &&
      other.movieId == movieId &&
      other.cardId == cardId &&
      other.cinemaId == cinemaId &&
      listEquals(other.snacks, snacks);
  }

  @override
  int get hashCode {
    return cinemaDayTimeslotId.hashCode ^
      row.hashCode ^
      seatNumber.hashCode ^
      bookingDate.hashCode ^
      totalPrice.hashCode ^
      movieId.hashCode ^
      cardId.hashCode ^
      cinemaId.hashCode ^
      snacks.hashCode;
  }
}
