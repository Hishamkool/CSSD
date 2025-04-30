// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'used_items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDepartmentwiseUsedItemListModel _$GetDepartmentwiseUsedItemListModelFromJson(
        Map<String, dynamic> json) =>
    GetDepartmentwiseUsedItemListModel(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map(
              (e) => UsedItemsListModelData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetDepartmentwiseUsedItemListModelToJson(
        GetDepartmentwiseUsedItemListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

UsedItemsListModelData _$UsedItemsListModelDataFromJson(
        Map<String, dynamic> json) =>
    UsedItemsListModelData(
      productId: (json['ProductID'] as num).toInt(),
      productName: json['ProductName'] as String,
      location: json['Location'] as String,
      uQty: (json['UQty'] as num).toInt(),
    );

Map<String, dynamic> _$UsedItemsListModelDataToJson(
        UsedItemsListModelData instance) =>
    <String, dynamic>{
      'ProductID': instance.productId,
      'ProductName': instance.productName,
      'Location': instance.location,
      'UQty': instance.uQty,
    };
