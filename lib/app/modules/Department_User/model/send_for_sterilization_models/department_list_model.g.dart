// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDepartmentListModel _$GetDepartmentListModelFromJson(
        Map<String, dynamic> json) =>
    GetDepartmentListModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              GetDepartmentListModelData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetDepartmentListModelToJson(
        GetDepartmentListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

GetDepartmentListModelData _$GetDepartmentListModelDataFromJson(
        Map<String, dynamic> json) =>
    GetDepartmentListModelData(
      subId: json['Sub_ID'] as String?,
      subName: json['SubName'] as String?,
    );

Map<String, dynamic> _$GetDepartmentListModelDataToJson(
        GetDepartmentListModelData instance) =>
    <String, dynamic>{
      'Sub_ID': instance.subId,
      'SubName': instance.subName,
    };
