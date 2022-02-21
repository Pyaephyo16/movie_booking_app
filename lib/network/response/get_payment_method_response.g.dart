// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_payment_method_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPaymentMethodResponse _$GetPaymentMethodResponseFromJson(
        Map<String, dynamic> json) =>
    GetPaymentMethodResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => PaymentVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPaymentMethodResponseToJson(
        GetPaymentMethodResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
