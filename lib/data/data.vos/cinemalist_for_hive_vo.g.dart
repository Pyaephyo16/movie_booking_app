// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinemalist_for_hive_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CinemaListForHiveVOAdapter extends TypeAdapter<CinemaListForHiveVO> {
  @override
  final int typeId = 13;

  @override
  CinemaListForHiveVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CinemaListForHiveVO(
      (fields[0] as List?)?.cast<CinemaVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, CinemaListForHiveVO obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.cinemaList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CinemaListForHiveVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaListForHiveVO _$CinemaListForHiveVOFromJson(Map<String, dynamic> json) =>
    CinemaListForHiveVO(
      (json['cinemaList'] as List<dynamic>?)
          ?.map((e) => CinemaVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CinemaListForHiveVOToJson(
        CinemaListForHiveVO instance) =>
    <String, dynamic>{
      'cinemaList': instance.cinemaList,
    };
