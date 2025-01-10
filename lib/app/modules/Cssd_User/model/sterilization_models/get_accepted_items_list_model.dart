import 'package:json_annotation/json_annotation.dart';
part 'get_accepted_items_list_model.g.dart';
/* http://192.168.0.251:65113/api/Home/GetAcceptedItem_List?itemname=bio */

@JsonSerializable()
class GetAcceptedItemList {
  @JsonKey(name: "status")
  int status;
  @JsonKey(name: "data")
  List<GetAcceptedItemListData> data;

  GetAcceptedItemList({
    required this.status,
    required this.data,
  });

  factory GetAcceptedItemList.fromJson(Map<String, dynamic> json) =>
      _$GetAcceptedItemListFromJson(json);

  Map<String, dynamic> toJson() => _$GetAcceptedItemListToJson(this);
}

@JsonSerializable()
class   GetAcceptedItemListData {
  @JsonKey(name: "Product_ID")
  int productId;
  @JsonKey(name: "SID")
  int sid;
  @JsonKey(name: "Product_Name")
  String productName;
  @JsonKey(name: "Qty")
  int qty;

  GetAcceptedItemListData({
    required this.productId,
    required this.sid,
    required this.productName,
    required this.qty,
  });

  factory GetAcceptedItemListData.fromJson(Map<String, dynamic> json) =>
      _$GetAcceptedItemListDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetAcceptedItemListDataToJson(this);
}


/* {
  "status": 200,
  "data": [
    {
      "Product_ID": 3,
      "SID": 2,
      "Product_Name": "BIOCOMPOSITE SCREW 10 X 28 MM",
      "Qty": 12
    },
    {
      "Product_ID": 3,
      "SID": 10,
      "Product_Name": "BIOCOMPOSITE SCREW 10 X 28 MM",
      "Qty": 2
    },
    {
      "Product_ID": 14,
      "SID": 12,
      "Product_Name": "BIOCOMPOSITE SCREW 10 X 28 MM",
      "Qty": 35
    },
    {
      "Product_ID": 3,
      "SID": 14,
      "Product_Name": "BIOCOMPOSITE SCREW 10 X 28 MM",
      "Qty": 5
    },
    {
      "Product_ID": 17,
      "SID": 15,
      "Product_Name": "BIOCOMPOSITE SCREW 8 X 28MM",
      "Qty": 5
    }
  ]
} */