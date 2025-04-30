import 'package:json_annotation/json_annotation.dart';
/* to display items on dashboard of department under my requests */
/* 'http://192.168.0.251:65113/api/Department/GetCssdSentItems?location=dermatology */

part 'get_cssd_send_requests.g.dart';
@JsonSerializable()
class GetCssdSentItems {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "data")
    List<GetCssdSentItemsData> data;

    GetCssdSentItems({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetCssdSentItems.fromJson(Map<String, dynamic> json) => _$GetCssdSentItemsFromJson(json);

    Map<String, dynamic> toJson() => _$GetCssdSentItemsToJson(this);
}

@JsonSerializable()
class GetCssdSentItemsData {
    @JsonKey(name: "Location")
    String location;
    @JsonKey(name: "ReqId")
    int reqId;
    @JsonKey(name: "ReqTime")
    DateTime reqTime;
    @JsonKey(name: "Requser")
    String requser;
    @JsonKey(name: "IsAccepted")
    bool isAccepted;
    @JsonKey(name: "AcceptedUser")
    dynamic acceptedUser;

    GetCssdSentItemsData({
        required this.location,
        required this.reqId,
        required this.reqTime,
        required this.requser,
        required this.isAccepted,
        required this.acceptedUser,
    });

    factory GetCssdSentItemsData.fromJson(Map<String, dynamic> json) => _$GetCssdSentItemsDataFromJson(json);

    Map<String, dynamic> toJson() => _$GetCssdSentItemsDataToJson(this);
}

/* {
  "status": 200,
  "message": "Item list fetched successfully",
  "data": [
    {
      "Location": "Dermatology",
      "ReqId": 1,
      "ReqTime": "2024-11-26T18:06:56.27",
      "Requser": "admin",
      "IsAccepted": false,
      "AcceptedUser": null
    },
    {
      "Location": "Dermatology",
      "ReqId": 2,
      "ReqTime": "2024-11-27T15:49:52.027",
      "Requser": "admin",
      "IsAccepted": false,
      "AcceptedUser": null
    }
  ]
} */