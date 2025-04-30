import 'package:json_annotation/json_annotation.dart';
part 'get_process_name_model.g.dart';

@JsonSerializable()
class GetProcessName {
  @JsonKey(name: "status")
  int status;
  @JsonKey(name: "data")
  List<GetProcessNameData> data;

  GetProcessName({
    required this.status,
    required this.data,
  });

  factory GetProcessName.fromJson(Map<String, dynamic> json) =>
      _$GetProcessNameFromJson(json);

  Map<String, dynamic> toJson() => _$GetProcessNameToJson(this);
}

@JsonSerializable()
class GetProcessNameData {
  @JsonKey(name: "ID")
  int id;
  @JsonKey(name: "ProcessName")
  String processName;
  @JsonKey(name: "Sequence")
  int sequence;
  @JsonKey(name: "Pressure")
  int pressure;
  @JsonKey(name: "PUnit")
  String pUnit;
  @JsonKey(name: "Temp")
  int temp;
  @JsonKey(name: "TUnit")
  String tUnit;
  @JsonKey(name: "BrdTime")
  int brdTime;
  @JsonKey(name: "CoolingTime")
  int coolingTime;

  GetProcessNameData({
    required this.id,
    required this.processName,
    required this.sequence,
    required this.pressure,
    required this.pUnit,
    required this.temp,
    required this.tUnit,
    required this.brdTime,
    required this.coolingTime,
  });

  factory GetProcessNameData.fromJson(Map<String, dynamic> json) =>
      _$GetProcessNameDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetProcessNameDataToJson(this);
}
