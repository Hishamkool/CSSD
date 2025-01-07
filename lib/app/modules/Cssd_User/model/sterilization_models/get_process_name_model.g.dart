// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_process_name_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProcessName _$GetProcessNameFromJson(Map<String, dynamic> json) =>
    GetProcessName(
      status: (json['status'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => GetProcessNameData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetProcessNameToJson(GetProcessName instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

GetProcessNameData _$GetProcessNameDataFromJson(Map<String, dynamic> json) =>
    GetProcessNameData(
      id: (json['ID'] as num).toInt(),
      processName: json['ProcessName'] as String,
      sequence: (json['Sequence'] as num).toInt(),
      pressure: (json['Pressure'] as num).toInt(),
      pUnit: json['PUnit'] as String,
      temp: (json['Temp'] as num).toInt(),
      tUnit: json['TUnit'] as String,
      brdTime: (json['BrdTime'] as num).toInt(),
      coolingTime: (json['CoolingTime'] as num).toInt(),
    );

Map<String, dynamic> _$GetProcessNameDataToJson(GetProcessNameData instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'ProcessName': instance.processName,
      'Sequence': instance.sequence,
      'Pressure': instance.pressure,
      'PUnit': instance.pUnit,
      'Temp': instance.temp,
      'TUnit': instance.tUnit,
      'BrdTime': instance.brdTime,
      'CoolingTime': instance.coolingTime,
    };
