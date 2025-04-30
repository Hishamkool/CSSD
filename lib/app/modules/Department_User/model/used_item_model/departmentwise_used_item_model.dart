import 'package:json_annotation/json_annotation.dart';

part 'departmentwise_used_item_model.g.dart';
/*   'http://192.168.0.251:65113/api/Department/Departmentwise_UsedItemList?location=dermatology' */

@JsonSerializable()
class DepartmentwiseUsedItemList {
  @JsonKey(name: "status")
  int status;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "data")
  List<DepartmentwiseUsedItemListData> data;

  DepartmentwiseUsedItemList({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DepartmentwiseUsedItemList.fromJson(Map<String, dynamic> json) =>
      _$DepartmentwiseUsedItemListFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentwiseUsedItemListToJson(this);
}

@JsonSerializable()
class DepartmentwiseUsedItemListData {
  @JsonKey(name: "ProductID")
  int productId;
  @JsonKey(name: "ProductName")
  String productName;
  @JsonKey(name: "Location")
  String location;
  @JsonKey(name: "UQty")
  int uQty;

  DepartmentwiseUsedItemListData({
    required this.productId,
    required this.productName,
    required this.location,
    required this.uQty,
  });

  factory DepartmentwiseUsedItemListData.fromJson(Map<String, dynamic> json) =>
      _$DepartmentwiseUsedItemListDataFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentwiseUsedItemListDataToJson(this);
}


/* Response 
{
  "status": 200,
  "message": "Successfully fetched data",
  "data": [
    {
      "ProductID": 14,
      "ProductName": "BIOCOMPOSITE SCREW 10 X 28 MM",
      "Location": "Dermatology",
      "UQty": 35
    },
    {
      "ProductID": 15,
      "ProductName": "1.5 SUTURE ANCHOR",
      "Location": "Dermatology",
      "UQty": 6
    },
    {
      "ProductID": 16,
      "ProductName": "ACL SCREW 9X25MM",
      "Location": "Dermatology",
      "UQty": 78
    }
  ]
}
 */