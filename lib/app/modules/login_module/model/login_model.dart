// class LoginModel {
//   int? status;
//   String? hospitalName;
//   int? hospitalID;
//   String? phone;
//   String? username;
//   String? token;
//   String? role;
//   String? message;
//   List<Previlages>? previlages;

//   LoginModel(
//       {this.status,
//       this.message,
//       this.hospitalName,
//       this.hospitalID,
//       this.phone,
//       this.username,
//       this.token,
//       this.role,
//       this.previlages});

//   LoginModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     hospitalName = json['HospitalName'];
//     hospitalID = json['HospitalID'];
//     phone = json['Phone'];
//     username = json['Username'];
//     token = json['Token'];
//     role = json['Role'];
//     message = json['message'];
//     if (json['Previlages'] != null) {
//       previlages = <Previlages>[];
//       json['Previlages'].forEach((v) {
//         previlages!.add(new Previlages.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['HospitalName'] = this.hospitalName;
//     data['HospitalID'] = this.hospitalID;
//     data['Phone'] = this.phone;
//     data['Username'] = this.username;
//     data['Token'] = this.token;
//     data['Role'] = this.role;
//     data['message'] = this.message;
//     if (this.previlages != null) {
//       data['Previlages'] = this.previlages!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }

// }

// class Previlages {
//   int? pRIVILEGES;

//   Previlages({this.pRIVILEGES});

//   Previlages.fromJson(Map<String, dynamic> json) {
//     pRIVILEGES = json['PRIVILEGES'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['PRIVILEGES'] = this.pRIVILEGES;
//     return data;
//   }

// }

class LoginModel {
  int? status;
  String? hospitalName;
  int? hospitalID;
  String? phone;
  String? username;
  String? token;
  String? role;
  String? message;
  List<Previlages>? previlages;

  LoginModel({
    this.status,
    this.message,
    this.hospitalName,
    this.hospitalID,
    this.phone,
    this.username,
    this.token,
    this.role,
    this.previlages,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    hospitalName = json['HospitalName'];
    hospitalID = json['HospitalID'];
    phone = json['Phone'];
    username = json['Username'];
    token = json['Token'];
    role = json['Role'];
    message = json['message'];
    if (json['Previlages'] != null) {
      previlages = <Previlages>[];
      json['Previlages'].forEach((v) {
        previlages!.add(Previlages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['HospitalName'] = hospitalName;
    data['HospitalID'] = hospitalID;
    data['Phone'] = phone;
    data['Username'] = username;
    data['Token'] = token;
    data['Role'] = role;
    data['message'] = message;
    if (previlages != null) {
      data['Previlages'] = previlages!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<String> getPrivileges() {
    return previlages?.map((privilege) => privilege.pRIVILEGES!.toString()).toList() ?? []; //null check
  }
}

class Previlages {
  int? pRIVILEGES;

  Previlages({this.pRIVILEGES});

  Previlages.fromJson(Map<String, dynamic> json) {
    pRIVILEGES = json['PRIVILEGES'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PRIVILEGES'] = this.pRIVILEGES;
    return data;
  }
}
