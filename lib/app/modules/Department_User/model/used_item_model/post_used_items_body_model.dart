/* class PostUsedItemsEntryModel {
/* http://192.168.0.251:65113/api/Department/UsedItemEntry */
  List<Uentry>? uentry;

  PostUsedItemsEntryModel({this.uentry});

  PostUsedItemsEntryModel.fromJson(Map<String, dynamic> json) {
    if (json['uentry'] != null) {
      uentry = <Uentry>[];
      json['uentry'].forEach((v) {
        uentry!.add(new Uentry.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.uentry != null) {
      data['uentry'] = this.uentry!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Uentry {
  int? productId;
  String? location;
  int? quantity;

  Uentry({this.productId, this.location, this.quantity});

  Uentry.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    location = json['location'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['location'] = this.location;
    data['quantity'] = this.quantity;
    return data;
  }
} */
import 'package:json_annotation/json_annotation.dart';
part 'post_used_items_body_model.g.dart';

/*
body model 
 http://192.168.0.251:65113/api/Department/UsedItemEntry 
 */ 


@JsonSerializable()
class PostUsedItemsEntryModel {
    @JsonKey(name: "uentry")
    List<Uentry> uentry;

    PostUsedItemsEntryModel({
        required this.uentry,
    });

    factory PostUsedItemsEntryModel.fromJson(Map<String, dynamic> json) => _$PostUsedItemsEntryModelFromJson(json);

    Map<String, dynamic> toJson() => _$PostUsedItemsEntryModelToJson(this);
}

@JsonSerializable()
class Uentry {
    @JsonKey(name: "productId")
    int productId;
    @JsonKey(name: "location")
    String location;
    @JsonKey(name: "quantity")
    int quantity;

    Uentry({
        required this.productId,
        required this.location,
        required this.quantity,
    });

    factory Uentry.fromJson(Map<String, dynamic> json) => _$UentryFromJson(json);

    Map<String, dynamic> toJson() => _$UentryToJson(this);
}

/* {
  "uentry": [
    {
      "productId": 0,
      "location": "string",
      "quantity": 0
    }
  ]
} */