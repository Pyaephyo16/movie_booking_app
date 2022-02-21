// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_credit_movie_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCreditMovieResponse _$GetCreditMovieResponseFromJson(
        Map<String, dynamic> json) =>
    GetCreditMovieResponse(
      json['id'] as int?,
      (json['cast'] as List<dynamic>?)
          ?.map((e) => ActorVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['crew'] as List<dynamic>?)
          ?.map((e) => ActorVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCreditMovieResponseToJson(
        GetCreditMovieResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cast': instance.cast,
      'crew': instance.crew,
    };
