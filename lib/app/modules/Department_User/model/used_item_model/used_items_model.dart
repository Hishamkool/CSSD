import 'package:json_annotation/json_annotation.dart';

part 'used_items_model.g.dart';
@JsonSerializable()
class GetDepartmentwiseUsedItemListModel {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "data")
    List<UsedItemsListModelData> data;

    GetDepartmentwiseUsedItemListModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetDepartmentwiseUsedItemListModel.fromJson(Map<String, dynamic> json) => _$GetDepartmentwiseUsedItemListModelFromJson(json);

    Map<String, dynamic> toJson() => _$GetDepartmentwiseUsedItemListModelToJson(this);
}

@JsonSerializable()
class UsedItemsListModelData {
    @JsonKey(name: "ProductID")
    int productId;
    @JsonKey(name: "ProductName")
    String productName;
    @JsonKey(name: "Location")
    String location;
    @JsonKey(name: "UQty")
    int uQty;

    UsedItemsListModelData({
        required this.productId,
        required this.productName,
        required this.location,
        required this.uQty,
    });

    factory UsedItemsListModelData.fromJson(Map<String, dynamic> json) => _$UsedItemsListModelDataFromJson(json);

    Map<String, dynamic> toJson() => _$UsedItemsListModelDataToJson(this);
}
