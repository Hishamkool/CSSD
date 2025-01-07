// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetItemNameModel _$GetItemNameModelFromJson(Map<String, dynamic> json) =>
    GetItemNameModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => GetItemNameModelData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetItemNameModelToJson(GetItemNameModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

GetItemNameModelData _$GetItemNameModelDataFromJson(
        Map<String, dynamic> json) =>
    GetItemNameModelData(
      iid: (json['IID'] as num?)?.toInt(),
      pid: (json['PID'] as num?)?.toInt(),
      productName: json['ProductName'] as String?,
      pckg: (json['Pckg'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetItemNameModelDataToJson(
        GetItemNameModelData instance) =>
    <String, dynamic>{
      'IID': instance.iid,
      'PID': instance.pid,
      'ProductName': instance.productName,
      'Pckg': instance.pckg,
    };
