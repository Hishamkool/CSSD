// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departmentwise_used_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentwiseUsedItemList _$DepartmentwiseUsedItemListFromJson(
        Map<String, dynamic> json) =>
    DepartmentwiseUsedItemList(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => DepartmentwiseUsedItemListData.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DepartmentwiseUsedItemListToJson(
        DepartmentwiseUsedItemList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

DepartmentwiseUsedItemListData _$DepartmentwiseUsedItemListDataFromJson(
        Map<String, dynamic> json) =>
    DepartmentwiseUsedItemListData(
      productId: (json['ProductID'] as num).toInt(),
      productName: json['ProductName'] as String,
      location: json['Location'] as String,
      uQty: (json['UQty'] as num).toInt(),
    );

Map<String, dynamic> _$DepartmentwiseUsedItemListDataToJson(
        DepartmentwiseUsedItemListData instance) =>
    <String, dynamic>{
      'ProductID': instance.productId,
      'ProductName': instance.productName,
      'Location': instance.location,
      'UQty': instance.uQty,
    };
