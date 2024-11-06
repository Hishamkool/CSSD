// To parse this JSON data, do
//
//     final departmentListModel = departmentListModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'depart_dropdown_jsonserializable.g.dart';

DepartmentListModel departmentListModelFromJson(String str) => DepartmentListModel.fromJson(json.decode(str));

String departmentListModelToJson(DepartmentListModel data) => json.encode(data.toJson());

@JsonSerializable()
class DepartmentListModel {
    @JsonKey(name: "status")
    final int? status;
    @JsonKey(name: "message")
    final String? message;
    @JsonKey(name: "data")
    final List<Datum>? data;

    DepartmentListModel({
        this.status,
        this.message,
        this.data,
    });

    factory DepartmentListModel.fromJson(Map<String, dynamic> json) => _$DepartmentListModelFromJson(json);

    Map<String, dynamic> toJson() => _$DepartmentListModelToJson(this);
}

@JsonSerializable()
class Datum {
    @JsonKey(name: "Sub_ID")
    final String? subId;
    @JsonKey(name: "SubName")
    final String? subName;

    Datum({
        this.subId,
        this.subName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

    Map<String, dynamic> toJson() => _$DatumToJson(this);
}
