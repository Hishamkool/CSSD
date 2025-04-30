import 'package:json_annotation/json_annotation.dart';
/* 'http://192.168.0.251:65113/api/Department/SendToCssd' - send body model */
part 'post_send_to_cssd_model.g.dart';
@JsonSerializable()
class PostSendToCssd {
    @JsonKey(name: "location")
    String location;
    @JsonKey(name: "priority")
    String priority;
    @JsonKey(name: "Remarks")
    String remarks;
    @JsonKey(name: "sendcssditems")
    List<Sendcssditem> sendcssditems;

    PostSendToCssd({
        required this.location,
        required this.priority,
        required this.remarks,
        required this.sendcssditems,
    });

    factory PostSendToCssd.fromJson(Map<String, dynamic> json) => _$PostSendToCssdFromJson(json);

    Map<String, dynamic> toJson() => _$PostSendToCssdToJson(this);
}

@JsonSerializable()
class Sendcssditem {
    @JsonKey(name: "Productname")
    String productname;
    @JsonKey(name: "ProductId")
    int productId;
    @JsonKey(name: "Qty")
    int qty;

    Sendcssditem({
        required this.productname,
        required this.productId,
        required this.qty,
    });

    factory Sendcssditem.fromJson(Map<String, dynamic> json) => _$SendcssditemFromJson(json);

    Map<String, dynamic> toJson() => _$SendcssditemToJson(this);
}



/* 
{
  "location": "string",
  "sendcssditems": [
    {
      "Productname": "string",
      "ProductId": 0,
      "Qty": 0
    }
  ]
} */