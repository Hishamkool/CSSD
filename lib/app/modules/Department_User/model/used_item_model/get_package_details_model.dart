// to get the items withing a package
import 'package:json_annotation/json_annotation.dart';

part 'get_package_details_model.g.dart';
@JsonSerializable()
class GetPackagedetails {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "data")
    List<GetPackagedetailsData> data;

    GetPackagedetails({
        required this.status,
        required this.data,
    });

    factory GetPackagedetails.fromJson(Map<String, dynamic> json) => _$GetPackagedetailsFromJson(json);

    Map<String, dynamic> toJson() => _$GetPackagedetailsToJson(this);
}

@JsonSerializable()
class GetPackagedetailsData {
    @JsonKey(name: "ID")
    int id;
    @JsonKey(name: "PckQty")
    int pckQty;
    @JsonKey(name: "ProductName")
    String productName;

    GetPackagedetailsData({
        required this.id,
        required this.pckQty,
        required this.productName,
    });

    factory GetPackagedetailsData.fromJson(Map<String, dynamic> json) => _$GetPackagedetailsDataFromJson(json);

    Map<String, dynamic> toJson() => _$GetPackagedetailsDataToJson(this);
}
