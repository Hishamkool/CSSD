// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_accepted_items_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAcceptedItemList _$GetAcceptedItemListFromJson(Map<String, dynamic> json) =>
    GetAcceptedItemList(
      status: (json['status'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              GetAcceptedItemListData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAcceptedItemListToJson(
        GetAcceptedItemList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

GetAcceptedItemListData _$GetAcceptedItemListDataFromJson(
        Map<String, dynamic> json) =>
    GetAcceptedItemListData(
      productId: (json['Product_ID'] as num).toInt(),
      sid: (json['SID'] as num).toInt(),
      productName: json['Product_Name'] as String,
      qty: (json['Qty'] as num).toInt(),
    );

Map<String, dynamic> _$GetAcceptedItemListDataToJson(
        GetAcceptedItemListData instance) =>
    <String, dynamic>{
      'Product_ID': instance.productId,
      'SID': instance.sid,
      'Product_Name': instance.productName,
      'Qty': instance.qty,
    };
