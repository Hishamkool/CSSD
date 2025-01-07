class PostUsedItemsEntryModel {
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