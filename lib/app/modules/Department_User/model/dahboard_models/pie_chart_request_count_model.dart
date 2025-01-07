import 'package:json_annotation/json_annotation.dart';

part 'pie_chart_request_count_model.g.dart';
@JsonSerializable()
class GetRequestCountModel {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "data")
    int data;

    GetRequestCountModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetRequestCountModel.fromJson(Map<String, dynamic> json) => _$GetRequestCountModelFromJson(json);

    Map<String, dynamic> toJson() => _$GetRequestCountModelToJson(this);
}
