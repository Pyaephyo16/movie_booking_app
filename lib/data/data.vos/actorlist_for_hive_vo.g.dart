// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actorlist_for_hive_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActorListForHiveVOAdapter extends TypeAdapter<ActorListForHiveVO> {
  @override
  final int typeId = 14;

  @override
  ActorListForHiveVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActorListForHiveVO(
      (fields[0] as List?)?.cast<ActorVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, ActorListForHiveVO obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.actorList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActorListForHiveVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorListForHiveVO _$ActorListForHiveVOFromJson(Map<String, dynamic> json) =>
    ActorListForHiveVO(
      (json['actorList'] as List<dynamic>?)
          ?.map((e) => ActorVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ActorListForHiveVOToJson(ActorListForHiveVO instance) =>
    <String, dynamic>{
      'actorList': instance.actorList,
    };
