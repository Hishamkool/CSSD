// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralResponse _$GeneralResponseFromJson(Map<String, dynamic> json) =>
    GeneralResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$GeneralResponseToJson(GeneralResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
