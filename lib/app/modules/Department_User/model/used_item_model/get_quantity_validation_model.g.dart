// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_quantity_validation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetQtyValidationModel _$GetQtyValidationModelFromJson(
        Map<String, dynamic> json) =>
    GetQtyValidationModel(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] as List<dynamic>,
    );

Map<String, dynamic> _$GetQtyValidationModelToJson(
        GetQtyValidationModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
