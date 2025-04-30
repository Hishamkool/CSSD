// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cssd_det_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCssdDet _$GetCssdDetFromJson(Map<String, dynamic> json) => GetCssdDet(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => GetCssdDetData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCssdDetToJson(GetCssdDet instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

GetCssdDetData _$GetCssdDetDataFromJson(Map<String, dynamic> json) =>
    GetCssdDetData(
      sid: (json['SID'] as num).toInt(),
      sub: json['Sub'] as String,
      productName: json['Product_Name'] as String,
      productId: (json['Product_ID'] as num).toInt(),
      qty: (json['Qty'] as num).toInt(),
      priority: json['Priority'] as String,
      rTime: DateTime.parse(json['RTime'] as String),
      ruser: json['Ruser'] as String,
      remarks: json['Remarks'] as String,
    );

Map<String, dynamic> _$GetCssdDetDataToJson(GetCssdDetData instance) =>
    <String, dynamic>{
      'SID': instance.sid,
      'Sub': instance.sub,
      'Product_Name': instance.productName,
      'Product_ID': instance.productId,
      'Qty': instance.qty,
      'Priority': instance.priority,
      'RTime': instance.rTime.toIso8601String(),
      'Ruser': instance.ruser,
      'Remarks': instance.remarks,
    };
