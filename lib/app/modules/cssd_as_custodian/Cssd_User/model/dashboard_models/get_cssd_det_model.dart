// details of a particular request
import 'package:json_annotation/json_annotation.dart';
part 'get_cssd_det_model.g.dart';
/* http://192.168.0.251:65113/api/Home/GetCSSD_Det?SID=11 */
@JsonSerializable()
class GetCssdDet {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "data")
    List<GetCssdDetData> data;

    GetCssdDet({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetCssdDet.fromJson(Map<String, dynamic> json) => _$GetCssdDetFromJson(json);

    Map<String, dynamic> toJson() => _$GetCssdDetToJson(this);
}

@JsonSerializable()
class GetCssdDetData {
    @JsonKey(name: "SID")
    int sid;
    @JsonKey(name: "Sub")
    String sub;
    @JsonKey(name: "Product_Name")
    String productName;
    @JsonKey(name: "Product_ID")
    int productId;
    @JsonKey(name: "Qty")
    int qty;
    @JsonKey(name: "Priority")
    String priority;
    @JsonKey(name: "RTime")
    DateTime rTime;
    @JsonKey(name: "Ruser")
    String ruser;
    @JsonKey(name: "Remarks")
    String remarks;

    GetCssdDetData({
        required this.sid,
        required this.sub,
        required this.productName,
        required this.productId,
        required this.qty,
        required this.priority,
        required this.rTime,
        required this.ruser,
        required this.remarks,
    });

    factory GetCssdDetData.fromJson(Map<String, dynamic> json) => _$GetCssdDetDataFromJson(json);

    Map<String, dynamic> toJson() => _$GetCssdDetDataToJson(this);
}


/* {
  "status": 200,
  "message": "Successfully Fetched",
  "data": [
    {
      "SID": 11,
      "Sub": "CARDIOLOGY",
      "Product_Name": "BIOCOMPOSITE SCREW 10 X 28 MM",
      "Product_ID": 3,
      "Qty": 0,
      "Priority": "Low",
      "RTime": "2024-11-28T11:53:54.06",
      "Ruser": "vishnuvijayan-itd",
      "Remarks": "test"
    },
    {
      "SID": 11,
      "Sub": "CARDIOLOGY",
      "Product_Name": "NEEDLE NO 24 X 1",
      "Product_ID": 2,
      "Qty": 1,
      "Priority": "Low",
      "RTime": "2024-11-28T11:53:54.06",
      "Ruser": "vishnuvijayan-itd",
      "Remarks": "test"
    }
  ]
} */