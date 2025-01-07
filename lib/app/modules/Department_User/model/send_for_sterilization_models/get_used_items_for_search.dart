import 'package:json_annotation/json_annotation.dart';

part 'get_used_items_for_search.g.dart';
@JsonSerializable()
class GetUsedItemsForSearchModel {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "data")
    List<GetUsedItemsForSearchData> data;

    GetUsedItemsForSearchModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetUsedItemsForSearchModel.fromJson(Map<String, dynamic> json) => _$GetUsedItemsForSearchModelFromJson(json);

    Map<String, dynamic> toJson() => _$GetUsedItemsForSearchModelToJson(this);
}

@JsonSerializable()
class GetUsedItemsForSearchData {
    @JsonKey(name: "ProductName")
    String productName;
    @JsonKey(name: "UprodId")
    int uprodId;
    @JsonKey(name: "ProductId")
    int productId;
    @JsonKey(name: "UsedQty")
    int usedQty;

    GetUsedItemsForSearchData({
        required this.productName,
        required this.uprodId,
        required this.productId,
        required this.usedQty,
    });

    factory GetUsedItemsForSearchData.fromJson(Map<String, dynamic> json) => _$GetUsedItemsForSearchDataFromJson(json);

    Map<String, dynamic> toJson() => _$GetUsedItemsForSearchDataToJson(this);
}
