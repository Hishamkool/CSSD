// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'depart_dropdown_jsonserializable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentListModel _$DepartmentListModelFromJson(Map<String, dynamic> json) =>
    DepartmentListModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DepartmentListModelToJson(
        DepartmentListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      subId: json['Sub_ID'] as String?,
      subName: json['SubName'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'Sub_ID': instance.subId,
      'SubName': instance.subName,
    };
