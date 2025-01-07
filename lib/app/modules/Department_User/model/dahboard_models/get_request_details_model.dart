import 'package:json_annotation/json_annotation.dart';
//request details or pending request details
/*     'http://192.168.0.251:65113/api/Department/GetPendingRequestdetails' \

  while click on pie , not using now 
 */
part 'get_request_details_model.g.dart';
@JsonSerializable()
class GetRequestDetailsModel {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "data")
    List<RequestDetailsData> data;

    GetRequestDetailsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetRequestDetailsModel.fromJson(Map<String, dynamic> json) => _$GetRequestDetailsModelFromJson(json);

    Map<String, dynamic> toJson() => _$GetRequestDetailsModelToJson(this);
}

@JsonSerializable()
class RequestDetailsData {
    @JsonKey(name: "ReqID")
    int reqId;
    @JsonKey(name: "Sub")
    String sub;
    @JsonKey(name: "Priority")
    String priority;
    @JsonKey(name: "Remarks")
    String remarks;
    @JsonKey(name: "RTime")
    DateTime rTime;
    @JsonKey(name: "RUser")
    String rUser;
    @JsonKey(name: "TransferredUser")
    String? transferredUser;
    @JsonKey(name: "ISAccept")
    int isAccept;
    @JsonKey(name: "AcceptedUser")
    String? acceptedUser;

    RequestDetailsData({
        required this.reqId,
        required this.sub,
        required this.priority,
        required this.remarks,
        required this.rTime,
        required this.rUser,
        required this.transferredUser,
        required this.isAccept,
        required this.acceptedUser,
    });

    factory RequestDetailsData.fromJson(Map<String, dynamic> json) => _$RequestDetailsDataFromJson(json);

    Map<String, dynamic> toJson() => _$RequestDetailsDataToJson(this);
}

/* {
  "status": 200,
  "message": "Pending request details",
  "data": [
    {
      "ReqID": 21,
      "Sub": "Dermatology",
      "Priority": "Normal",
      "Remarks": "",
      "RTime": "2024-11-19T16:12:33.757",
      "RUser": "admin",
      "TransferredUser": null,
      "ISAccept": 0,
      "AcceptedUser": null
    }
  ]
} */