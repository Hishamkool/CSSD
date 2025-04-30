// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_machine_name_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMachineName _$GetMachineNameFromJson(Map<String, dynamic> json) =>
    GetMachineName(
      status: (json['status'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => GetMachineNameData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMachineNameToJson(GetMachineName instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

GetMachineNameData _$GetMachineNameDataFromJson(Map<String, dynamic> json) =>
    GetMachineNameData(
      machineId: (json['MachineID'] as num).toInt(),
      machineName: json['MachineName'] as String,
      genericName: json['GenericName'] as String,
    );

Map<String, dynamic> _$GetMachineNameDataToJson(GetMachineNameData instance) =>
    <String, dynamic>{
      'MachineID': instance.machineId,
      'MachineName': instance.machineName,
      'GenericName': instance.genericName,
    };
