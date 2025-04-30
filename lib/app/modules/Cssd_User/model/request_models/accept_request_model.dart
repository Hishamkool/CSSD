import 'package:json_annotation/json_annotation.dart';

/* http://192.168.0.251:65113/api/Home/AcceptRequest?SID=9 */
part 'accept_request_model.g.dart';
@JsonSerializable()
class AcceptRequest {
  @JsonKey(name: "status")
  int status;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "data")
  AcceptRequestData data;

  AcceptRequest({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AcceptRequest.fromJson(Map<String, dynamic> json) =>
      _$AcceptRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptRequestToJson(this);
}

@JsonSerializable()
class AcceptRequestData {
  @JsonKey(name: "SID")
  int sid;
  @JsonKey(name: "Sub")
  String sub;
  @JsonKey(name: "Priority")
  String priority;
  @JsonKey(name: "Remarks")
  String remarks;
  @JsonKey(name: "RTime")
  DateTime rTime;
  @JsonKey(name: "Ruser")
  String ruser;
  @JsonKey(name: "IsAccepted")
  bool isAccepted;
  @JsonKey(name: "Accepted_User")
  String acceptedUser;
  @JsonKey(name: "EnteredAt")
  DateTime enteredAt;

  AcceptRequestData({
    required this.sid,
    required this.sub,
    required this.priority,
    required this.remarks,
    required this.rTime,
    required this.ruser,
    required this.isAccepted,
    required this.acceptedUser,
    required this.enteredAt,
  });

  factory AcceptRequestData.fromJson(Map<String, dynamic> json) =>
      _$AcceptRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptRequestDataToJson(this);
}


/* {
  "status": 200,
  "message": "Request Accepted by admin",
  "data": {
    "SID": 9,
    "Sub": "CARDIOLOGY",
    "Priority": "Low",
    "Remarks": "priority set",
    "RTime": "2024-11-28T11:35:19.01",
    "Ruser": "vishnuvijayan-itd",
    "IsAccepted": true,
    "Accepted_User": "admin",
    "EnteredAt": "2024-11-28T11:35:19.01"
  }
} */