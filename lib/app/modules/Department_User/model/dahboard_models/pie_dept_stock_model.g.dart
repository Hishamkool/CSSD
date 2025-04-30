// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pie_dept_stock_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDepartmentwiseStockDetailsModel _$GetDepartmentwiseStockDetailsModelFromJson(
        Map<String, dynamic> json) =>
    GetDepartmentwiseStockDetailsModel(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => DepartmentStockData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetDepartmentwiseStockDetailsModelToJson(
        GetDepartmentwiseStockDetailsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

DepartmentStockData _$DepartmentStockDataFromJson(Map<String, dynamic> json) =>
    DepartmentStockData(
      productName: json['ProductName'] as String,
      productId: (json['ProductID'] as num).toInt(),
      stock: (json['Stock'] as num).toInt(),
    );

Map<String, dynamic> _$DepartmentStockDataToJson(
        DepartmentStockData instance) =>
    <String, dynamic>{
      'ProductName': instance.productName,
      'ProductID': instance.productId,
      'Stock': instance.stock,
    };
