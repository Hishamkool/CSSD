// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_used_items_for_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUsedItemsForSearchModel _$GetUsedItemsForSearchModelFromJson(
        Map<String, dynamic> json) =>
    GetUsedItemsForSearchModel(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              GetUsedItemsForSearchData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetUsedItemsForSearchModelToJson(
        GetUsedItemsForSearchModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

GetUsedItemsForSearchData _$GetUsedItemsForSearchDataFromJson(
        Map<String, dynamic> json) =>
    GetUsedItemsForSearchData(
      productName: json['ProductName'] as String,
      uprodId: (json['UprodId'] as num).toInt(),
      productId: (json['ProductId'] as num).toInt(),
      usedQty: (json['UsedQty'] as num).toInt(),
    );

Map<String, dynamic> _$GetUsedItemsForSearchDataToJson(
        GetUsedItemsForSearchData instance) =>
    <String, dynamic>{
      'ProductName': instance.productName,
      'UprodId': instance.uprodId,
      'ProductId': instance.productId,
      'UsedQty': instance.usedQty,
    };
