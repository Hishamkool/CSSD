import 'package:json_annotation/json_annotation.dart';
part 'get_cssd_list_model.g.dart';
/* http://192.168.0.251:65113/api/Home/GetCSSD_List */

@JsonSerializable()
class GetCssdList {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "data")
    GetCssdListData data;

    GetCssdList({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetCssdList.fromJson(Map<String, dynamic> json) => _$GetCssdListFromJson(json);

    Map<String, dynamic> toJson() => _$GetCssdListToJson(this);
}

@JsonSerializable()
class GetCssdListData {
    @JsonKey(name: "low")
    List<HighMedLowReqModel> low;
    @JsonKey(name: "medium")
    List<HighMedLowReqModel> medium;
    @JsonKey(name: "high")
    List<HighMedLowReqModel> high;

    GetCssdListData({
        required this.low,
        required this.medium,
        required this.high,
    });

    factory GetCssdListData.fromJson(Map<String, dynamic> json) => _$GetCssdListDataFromJson(json);

    Map<String, dynamic> toJson() => _$GetCssdListDataToJson(this);
}

@JsonSerializable()
class HighMedLowReqModel {
    @JsonKey(name: "SID")
    int sid;
    @JsonKey(name: "Sub")
    String sub;
    @JsonKey(name: "Productdet")
    List<Productdet> productdet;
    @JsonKey(name: "Priority")
    String priority;
    @JsonKey(name: "RTime")
    DateTime rTime;
    @JsonKey(name: "Ruser")
    String ruser;
    @JsonKey(name: "Remarks")
    String? remarks;

    HighMedLowReqModel({
        required this.sid,
        required this.sub,
        required this.productdet,
        required this.priority,
        required this.rTime,
        required this.ruser,
        this.remarks,
    });

    factory HighMedLowReqModel.fromJson(Map<String, dynamic> json) => _$HighMedLowReqModelFromJson(json);

    Map<String, dynamic> toJson() => _$HighMedLowReqModelToJson(this);
}

@JsonSerializable()
class Productdet {
    @JsonKey(name: "Product_ID")
    int productId;
    @JsonKey(name: "Product_Name")
    String productName;
    @JsonKey(name: "Qty")
    int qty;

    Productdet({
        required this.productId,
        required this.productName,
        required this.qty,
    });

    factory Productdet.fromJson(Map<String, dynamic> json) => _$ProductdetFromJson(json);

    Map<String, dynamic> toJson() => _$ProductdetToJson(this);
}


/* {
  "status": 200,
  "message": "Successfully Fetched",
  "data": {
    "low": [
      {
        "SID": 2,
        "Sub": "Dermatology",
        "Productdet": [
          {
            "Product_ID": 3,
            "Product_Name": "BIOCOMPOSITE SCREW 10 X 28 MM",
            "Qty": 12
          }
        ],
        "Priority": "Low",
        "RTime": "2024-11-27T15:49:52.027",
        "Ruser": "admin",
        "Remarks": "this is a sample remarks "
      },
      {
        "SID": 9,
        "Sub": "CARDIOLOGY",
        "Productdet": [
          {
            "Product_ID": 2,
            "Product_Name": "NEEDLE NO 24 X 1",
            "Qty": 12
          }
        ],
        "Priority": "Low",
        "RTime": "2024-11-28T11:35:19.01",
        "Ruser": "vishnuvijayan-itd",
        "Remarks": "priority set"
      },
      {
        "SID": 11,
        "Sub": "CARDIOLOGY",
        "Productdet": [
          {
            "Product_ID": 3,
            "Product_Name": "BIOCOMPOSITE SCREW 10 X 28 MM",
            "Qty": 0
          },
          {
            "Product_ID": 2,
            "Product_Name": "NEEDLE NO 24 X 1",
            "Qty": 1
          }
        ],
        "Priority": "Low",
        "RTime": "2024-11-28T11:53:54.06",
        "Ruser": "vishnuvijayan-itd",
        "Remarks": "test"
      },
      {
        "SID": 13,
        "Sub": "Test",
        "Productdet": [
          {
            "Product_ID": 14,
            "Product_Name": "BIOCOMPOSITE SCREW 10 X 28 MM",
            "Qty": 3
          }
        ],
        "Priority": "low",
        "RTime": "2024-12-04T14:20:48.74",
        "Ruser": "vishnus-adm",
        "Remarks": "testdata"
      }
    ],
    "medium": [
      {
        "SID": 5,
        "Sub": "CARDIOLOGY",
        "Productdet": [
          {
            "Product_ID": 2,
            "Product_Name": "NEEDLE NO 24 X 1",
            "Qty": 3
          }
        ],
        "Priority": "Medium",
        "RTime": "2024-11-28T11:30:00.783",
        "Ruser": "vishnuvijayan-itd"
      },
      {
        "SID": 12,
        "Sub": "Dermatology",
        "Productdet": [
          {
            "Product_ID": 14,
            "Product_Name": "BIOCOMPOSITE SCREW 10 X 28 MM",
            "Qty": 35
          }
        ],
        "Priority": "Medium",
        "RTime": "2024-11-28T18:18:16.643",
        "Ruser": "admin"
      }
    ],
    "high": [
      {
        "SID": 10,
        "Sub": "CARDIOLOGY",
        "Productdet": [
          {
            "Product_ID": 3,
            "Product_Name": "BIOCOMPOSITE SCREW 10 X 28 MM",
            "Qty": 2
          }
        ],
        "Priority": "High",
        "RTime": "2024-11-28T11:49:06.767",
        "Ruser": "vishnuvijayan-itd"
      }
    ]
  }
} */