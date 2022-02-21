// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_select_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSelectVO _$UserSelectVOFromJson(Map<String, dynamic> json) => UserSelectVO(
      json['id'] as int?,
      json['booking_no'] as String?,
      json['booking_date'] as String?,
      json['row'] as String?,
      json['seat'] as String?,
      json['total_seat'] as int?,
      json['total'] as String?,
      json['movie_id'] as int?,
      json['cinema_id'] as int?,
      json['username'] as String?,
      json['timeslot'] == null
          ? null
          : TimeslotVO.fromJson(json['timeslot'] as Map<String, dynamic>),
      (json['snacks'] as List<dynamic>?)
          ?.map((e) => SnackVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserSelectVOToJson(UserSelectVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'booking_no': instance.bookingNo,
      'booking_date': instance.bookingDate,
      'row': instance.row,
      'seat': instance.seat,
      'total_seat': instance.totalSeat,
      'total': instance.total,
      'movie_id': instance.movieId,
      'cinema_id': instance.cinemaId,
      'username': instance.userName,
      'timeslot': instance.timeslot,
      'snacks': instance.snacks,
    };
