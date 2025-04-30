import 'package:json_annotation/json_annotation.dart';
/* http://192.168.0.251:65113/api/Department/GetItemName?department=&itemname= */
part 'items_list_model.g.dart';
@JsonSerializable()
class GetItemNameModel {
    @JsonKey(name: "status")
    final int? status;
    @JsonKey(name: "message")
    final String? message;
    @JsonKey(name: "data")
    final List<GetItemNameModelData>? data;

    GetItemNameModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetItemNameModel.fromJson(Map<String, dynamic> json) => _$GetItemNameModelFromJson(json);

    Map<String, dynamic> toJson() => _$GetItemNameModelToJson(this);
}

@JsonSerializable()
class GetItemNameModelData {
    @JsonKey(name: "IID")
    final int? iid;
    @JsonKey(name: "PID")
    final int? pid;
    @JsonKey(name: "ProductName")
    final String? productName;
    @JsonKey(name: "Pckg")
    final int? pckg;

    GetItemNameModelData({
        this.iid,
        this.pid,
        this.productName,
        this.pckg,
    });

    factory GetItemNameModelData.fromJson(Map<String, dynamic> json) => _$GetItemNameModelDataFromJson(json);

    Map<String, dynamic> toJson() => _$GetItemNameModelDataToJson(this);
}

/* {
  "status": 200,
  "message": "Successfully fetched",
  "data": [
    {
      "IID": 2,
      "PID": 2,
      "ProductName": "aa",
      "Pckg": 1
    }
  ]
} */