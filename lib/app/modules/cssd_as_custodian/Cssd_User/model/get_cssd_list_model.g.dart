// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cssd_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCssdList _$GetCssdListFromJson(Map<String, dynamic> json) => GetCssdList(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: GetCssdListData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCssdListToJson(GetCssdList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

GetCssdListData _$GetCssdListDataFromJson(Map<String, dynamic> json) =>
    GetCssdListData(
      low: (json['low'] as List<dynamic>)
          .map((e) => HighMedLowReqModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      medium: (json['medium'] as List<dynamic>)
          .map((e) => HighMedLowReqModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      high: (json['high'] as List<dynamic>)
          .map((e) => HighMedLowReqModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCssdListDataToJson(GetCssdListData instance) =>
    <String, dynamic>{
      'low': instance.low,
      'medium': instance.medium,
      'high': instance.high,
    };

HighMedLowReqModel _$HighMedLowReqModelFromJson(Map<String, dynamic> json) =>
    HighMedLowReqModel(
      sid: (json['SID'] as num).toInt(),
      sub: json['Sub'] as String,
      productdet: (json['Productdet'] as List<dynamic>)
          .map((e) => Productdet.fromJson(e as Map<String, dynamic>))
          .toList(),
      priority: json['Priority'] as String,
      rTime: DateTime.parse(json['RTime'] as String),
      ruser: json['Ruser'] as String,
      remarks: json['Remarks'] as String?,
    );

Map<String, dynamic> _$HighMedLowReqModelToJson(HighMedLowReqModel instance) =>
    <String, dynamic>{
      'SID': instance.sid,
      'Sub': instance.sub,
      'Productdet': instance.productdet,
      'Priority': instance.priority,
      'RTime': instance.rTime.toIso8601String(),
      'Ruser': instance.ruser,
      'Remarks': instance.remarks,
    };

Productdet _$ProductdetFromJson(Map<String, dynamic> json) => Productdet(
      productId: (json['Product_ID'] as num).toInt(),
      productName: json['Product_Name'] as String,
      qty: (json['Qty'] as num).toInt(),
    );

Map<String, dynamic> _$ProductdetToJson(Productdet instance) =>
    <String, dynamic>{
      'Product_ID': instance.productId,
      'Product_Name': instance.productName,
      'Qty': instance.qty,
    };
