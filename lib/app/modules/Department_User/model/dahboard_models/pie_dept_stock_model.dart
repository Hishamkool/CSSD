import 'package:json_annotation/json_annotation.dart';

part 'pie_dept_stock_model.g.dart';
@JsonSerializable()
class GetDepartmentwiseStockDetailsModel {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "data")
    List<DepartmentStockData> data;

    GetDepartmentwiseStockDetailsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetDepartmentwiseStockDetailsModel.fromJson(Map<String, dynamic> json) => _$GetDepartmentwiseStockDetailsModelFromJson(json);

    Map<String, dynamic> toJson() => _$GetDepartmentwiseStockDetailsModelToJson(this);
}

@JsonSerializable()
class DepartmentStockData {
    @JsonKey(name: "ProductName")
    String productName;
    @JsonKey(name: "ProductID")
    int productId;
    @JsonKey(name: "Stock")
    int stock;

    DepartmentStockData({
        required this.productName,
        required this.productId,
        required this.stock,
    });

    factory DepartmentStockData.fromJson(Map<String, dynamic> json) => _$DepartmentStockDataFromJson(json);

    Map<String, dynamic> toJson() => _$DepartmentStockDataToJson(this);
}
