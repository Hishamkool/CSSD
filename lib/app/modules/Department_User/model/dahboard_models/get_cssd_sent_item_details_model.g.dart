// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cssd_sent_item_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCssdSentItemDetails _$GetCssdSentItemDetailsFromJson(
        Map<String, dynamic> json) =>
    GetCssdSentItemDetails(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              GetCssdSentItemDetailsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCssdSentItemDetailsToJson(
        GetCssdSentItemDetails instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

GetCssdSentItemDetailsData _$GetCssdSentItemDetailsDataFromJson(
        Map<String, dynamic> json) =>
    GetCssdSentItemDetailsData(
      sid: (json['SID'] as num).toInt(),
      productId: (json['Product_ID'] as num).toInt(),
      productName: json['Product_Name'] as String,
      qty: (json['Qty'] as num).toInt(),
    );

Map<String, dynamic> _$GetCssdSentItemDetailsDataToJson(
        GetCssdSentItemDetailsData instance) =>
    <String, dynamic>{
      'SID': instance.sid,
      'Product_ID': instance.productId,
      'Product_Name': instance.productName,
      'Qty': instance.qty,
    };
