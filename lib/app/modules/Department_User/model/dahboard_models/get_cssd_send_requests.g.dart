// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cssd_send_requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCssdSentItems _$GetCssdSentItemsFromJson(Map<String, dynamic> json) =>
    GetCssdSentItems(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => GetCssdSentItemsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCssdSentItemsToJson(GetCssdSentItems instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

GetCssdSentItemsData _$GetCssdSentItemsDataFromJson(
        Map<String, dynamic> json) =>
    GetCssdSentItemsData(
      location: json['Location'] as String,
      reqId: (json['ReqId'] as num).toInt(),
      reqTime: DateTime.parse(json['ReqTime'] as String),
      requser: json['Requser'] as String,
      isAccepted: json['IsAccepted'] as bool,
      acceptedUser: json['AcceptedUser'],
    );

Map<String, dynamic> _$GetCssdSentItemsDataToJson(
        GetCssdSentItemsData instance) =>
    <String, dynamic>{
      'Location': instance.location,
      'ReqId': instance.reqId,
      'ReqTime': instance.reqTime.toIso8601String(),
      'Requser': instance.requser,
      'IsAccepted': instance.isAccepted,
      'AcceptedUser': instance.acceptedUser,
    };
