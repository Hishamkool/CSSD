// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pie_chart_request_count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRequestCountModel _$GetRequestCountModelFromJson(
        Map<String, dynamic> json) =>
    GetRequestCountModel(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as num).toInt(),
    );

Map<String, dynamic> _$GetRequestCountModelToJson(
        GetRequestCountModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
