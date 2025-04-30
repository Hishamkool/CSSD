import 'package:json_annotation/json_annotation.dart';
part 'general_response_model.g.dart';
@JsonSerializable()
class GeneralResponse {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "message")
    String message;

    GeneralResponse({
        required this.status,
        required this.message,
    });

    factory GeneralResponse.fromJson(Map<String, dynamic> json) => _$GeneralResponseFromJson(json);

    Map<String, dynamic> toJson() => _$GeneralResponseToJson(this);
}
