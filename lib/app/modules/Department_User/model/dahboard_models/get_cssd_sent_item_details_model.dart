import 'package:json_annotation/json_annotation.dart';

/* http://192.168.0.251:65113/api/Department/GetCssdSentItem_Details?Sid= */

part 'get_cssd_sent_item_details_model.g.dart';
@JsonSerializable()
class GetCssdSentItemDetails {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "data")
    List<GetCssdSentItemDetailsData> data;

    GetCssdSentItemDetails({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetCssdSentItemDetails.fromJson(Map<String, dynamic> json) => _$GetCssdSentItemDetailsFromJson(json);

    Map<String, dynamic> toJson() => _$GetCssdSentItemDetailsToJson(this);
}

@JsonSerializable()
class GetCssdSentItemDetailsData {
    @JsonKey(name: "SID")
    int sid;
    @JsonKey(name: "Product_ID")
    int productId;
    @JsonKey(name: "Product_Name")
    String productName;
    @JsonKey(name: "Qty")
    int qty;

    GetCssdSentItemDetailsData({
        required this.sid,
        required this.productId,
        required this.productName,
        required this.qty,
    });

    factory GetCssdSentItemDetailsData.fromJson(Map<String, dynamic> json) => _$GetCssdSentItemDetailsDataFromJson(json);

    Map<String, dynamic> toJson() => _$GetCssdSentItemDetailsDataToJson(this);
}


/* {
  "status": 200,
  "message": "Item details fetched successfully",
  "data": [
    {
      "SID": 11,
      "Product_ID": 3,
      "Product_Name": "BIOCOMPOSITE SCREW 10 X 28 MM",
      "Qty": 2   
    },
    {
      "SID": 11,
      "Product_ID": 2,
      "Product_Name": "NEEDLE NO 24 X 1",
      "Qty": 3
    }
  ]
} */