import 'package:json_annotation/json_annotation.dart';

part 'get_quantity_validation_model.g.dart';
@JsonSerializable()
class GetQtyValidationModel {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "data")
    List<dynamic> data;

    GetQtyValidationModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetQtyValidationModel.fromJson(Map<String, dynamic> json) => _$GetQtyValidationModelFromJson(json);

    Map<String, dynamic> toJson() => _$GetQtyValidationModelToJson(this);
}
