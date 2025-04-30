class PreLoginAuthenticationModel {
  int? status;
  List<Data>? data;
  String? message;

  PreLoginAuthenticationModel({this.status, this.data, this.message});

  PreLoginAuthenticationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? hospitalId;
  String? hospitalName;

  Data({this.hospitalId, this.hospitalName});

  Data.fromJson(Map<String, dynamic> json) {
    hospitalId = json['Hospital_Id'];
    hospitalName = json['Hospital_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Hospital_Id'] = this.hospitalId;
    data['Hospital_Name'] = this.hospitalName;
    return data;
  }
}


/*
response
{
  "status": 200,
  "data": [
    {
      "Hospital_Id": 56,
      "Hospital_Name": "GRAPES IDMR"
    }
  ],
  "message": "Authentication successful"
}
 */