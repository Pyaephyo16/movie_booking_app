// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieListResponse _$MovieListResponseFromJson(Map<String, dynamic> json) =>
    MovieListResponse(
      json['dates'] == null
          ? null
          : DateVO.fromJson(json['dates'] as Map<String, dynamic>),
      json['int'] as int?,
      (json['results'] as List<dynamic>?)
          ?.map((e) => MovieVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total_pages'] as int?,
      json['total_results'] as int?,
    );

Map<String, dynamic> _$MovieListResponseToJson(MovieListResponse instance) =>
    <String, dynamic>{
      'dates': instance.dates,
      'int': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
