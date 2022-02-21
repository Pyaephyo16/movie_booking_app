// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_and_register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginAndRegisterResponse _$LoginAndRegisterResponseFromJson(
        Map<String, dynamic> json) =>
    LoginAndRegisterResponse(
      json['code'] as int?,
      json['message'] as String?,
      json['data'] == null
          ? null
          : UserVO.fromJson(json['data'] as Map<String, dynamic>),
      json['token'] as String?,
    );

Map<String, dynamic> _$LoginAndRegisterResponseToJson(
        LoginAndRegisterResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'token': instance.token,
    };
