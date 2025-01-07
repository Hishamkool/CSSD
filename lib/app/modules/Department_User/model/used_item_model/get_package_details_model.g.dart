// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_package_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPackagedetails _$GetPackagedetailsFromJson(Map<String, dynamic> json) =>
    GetPackagedetails(
      status: (json['status'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => GetPackagedetailsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPackagedetailsToJson(GetPackagedetails instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

GetPackagedetailsData _$GetPackagedetailsDataFromJson(
        Map<String, dynamic> json) =>
    GetPackagedetailsData(
      id: (json['ID'] as num).toInt(),
      pckQty: (json['PckQty'] as num).toInt(),
      productName: json['ProductName'] as String,
    );

Map<String, dynamic> _$GetPackagedetailsDataToJson(
        GetPackagedetailsData instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'PckQty': instance.pckQty,
      'ProductName': instance.productName,
    };
