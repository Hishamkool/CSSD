// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_request_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRequestDetailsModel _$GetRequestDetailsModelFromJson(
        Map<String, dynamic> json) =>
    GetRequestDetailsModel(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => RequestDetailsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetRequestDetailsModelToJson(
        GetRequestDetailsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

RequestDetailsData _$RequestDetailsDataFromJson(Map<String, dynamic> json) =>
    RequestDetailsData(
      reqId: (json['ReqID'] as num).toInt(),
      sub: json['Sub'] as String,
      priority: json['Priority'] as String,
      remarks: json['Remarks'] as String,
      rTime: DateTime.parse(json['RTime'] as String),
      rUser: json['RUser'] as String,
      transferredUser: json['TransferredUser'] as String?,
      isAccept: (json['ISAccept'] as num).toInt(),
      acceptedUser: json['AcceptedUser'] as String?,
    );

Map<String, dynamic> _$RequestDetailsDataToJson(RequestDetailsData instance) =>
    <String, dynamic>{
      'ReqID': instance.reqId,
      'Sub': instance.sub,
      'Priority': instance.priority,
      'Remarks': instance.remarks,
      'RTime': instance.rTime.toIso8601String(),
      'RUser': instance.rUser,
      'TransferredUser': instance.transferredUser,
      'ISAccept': instance.isAccept,
      'AcceptedUser': instance.acceptedUser,
    };
