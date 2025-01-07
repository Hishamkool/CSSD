import 'package:json_annotation/json_annotation.dart';
part 'get_machine_name_model.g.dart';
@JsonSerializable()
class GetMachineName {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "data")
    List<GetMachineNameData> data;

    GetMachineName({
        required this.status,
        required this.data,
    });

    factory GetMachineName.fromJson(Map<String, dynamic> json) => _$GetMachineNameFromJson(json);

    Map<String, dynamic> toJson() => _$GetMachineNameToJson(this);
}

@JsonSerializable()
class GetMachineNameData {
    @JsonKey(name: "MachineID")
    int machineId;
    @JsonKey(name: "MachineName")
    String machineName;
    @JsonKey(name: "GenericName")
    String genericName;

    GetMachineNameData({
        required this.machineId,
        required this.machineName,
        required this.genericName,
    });

    factory GetMachineNameData.fromJson(Map<String, dynamic> json) => _$GetMachineNameDataFromJson(json);

    Map<String, dynamic> toJson() => _$GetMachineNameDataToJson(this);
}
