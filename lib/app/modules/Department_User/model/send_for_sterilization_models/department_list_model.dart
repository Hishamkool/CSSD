import 'package:json_annotation/json_annotation.dart';

part 'department_list_model.g.dart';

@JsonSerializable()
class GetDepartmentListModel {
    @JsonKey(name: "status")
    final int? status;
    @JsonKey(name: "message")
    final String? message;
    @JsonKey(name: "data")
    final List<GetDepartmentListModelData>? data;

    GetDepartmentListModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetDepartmentListModel.fromJson(Map<String, dynamic> json) => _$GetDepartmentListModelFromJson(json);

    Map<String, dynamic> toJson() => _$GetDepartmentListModelToJson(this);
}

@JsonSerializable()
class GetDepartmentListModelData {
    @JsonKey(name: "Sub_ID")
    final String? subId;
    @JsonKey(name: "SubName")
    final String? subName;

    GetDepartmentListModelData({
        this.subId,
        this.subName,
    });

    factory GetDepartmentListModelData.fromJson(Map<String, dynamic> json) => _$GetDepartmentListModelDataFromJson(json);

    Map<String, dynamic> toJson() => _$GetDepartmentListModelDataToJson(this);
}
