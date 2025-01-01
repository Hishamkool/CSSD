// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcceptRequest _$AcceptRequestFromJson(Map<String, dynamic> json) =>
    AcceptRequest(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: AcceptRequestData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AcceptRequestToJson(AcceptRequest instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

AcceptRequestData _$AcceptRequestDataFromJson(Map<String, dynamic> json) =>
    AcceptRequestData(
      sid: (json['SID'] as num).toInt(),
      sub: json['Sub'] as String,
      priority: json['Priority'] as String,
      remarks: json['Remarks'] as String,
      rTime: DateTime.parse(json['RTime'] as String),
      ruser: json['Ruser'] as String,
      isAccepted: json['IsAccepted'] as bool,
      acceptedUser: json['Accepted_User'] as String,
      enteredAt: DateTime.parse(json['EnteredAt'] as String),
    );

Map<String, dynamic> _$AcceptRequestDataToJson(AcceptRequestData instance) =>
    <String, dynamic>{
      'SID': instance.sid,
      'Sub': instance.sub,
      'Priority': instance.priority,
      'Remarks': instance.remarks,
      'RTime': instance.rTime.toIso8601String(),
      'Ruser': instance.ruser,
      'IsAccepted': instance.isAccepted,
      'Accepted_User': instance.acceptedUser,
      'EnteredAt': instance.enteredAt.toIso8601String(),
    };
