// class DepartmentListModel {
//   int? status;
//   String? message;
//   List<DepartmentListData>? data;

//   DepartmentListModel({this.status, this.message, this.data});

//   DepartmentListModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <DepartmentListData>[];
//       json['data'].forEach((v) {
//         data!.add(new DepartmentListData.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class DepartmentListData {
//   String? subID;
//   String? subName;

//   DepartmentListData({this.subID, this.subName});

//   DepartmentListData.fromJson(Map<String, dynamic> json) {
//     subID = json['Sub_ID'];
//     subName = json['SubName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Sub_ID'] = this.subID;
//     data['SubName'] = this.subName;
//     return data;
//   }
// }




// // // To parse this JSON data, do
// // //
// // //     final departmentListModel = departmentListModelFromJson(jsonString);

// // import 'dart:convert';

// // DepartmentListModel departmentListModelFromJson(String str) => DepartmentListModel.fromJson(json.decode(str));

// // String departmentListModelToJson(DepartmentListModel data) => json.encode(data.toJson());

// // class DepartmentListModel {
// //     int status;
// //     String message;
// //     List<DepartementsData> data;

// //     DepartmentListModel({
// //         required this.status,
// //         required this.message,
// //         required this.data,
// //     });

// //     factory DepartmentListModel.fromJson(Map<String, dynamic> json) => DepartmentListModel(
// //         status: json["status"],
// //         message: json["message"],
// //         data: List<DepartementsData>.from(json["data"].map((x) => DepartementsData.fromJson(x))),
// //     );

// //     Map<String, dynamic> toJson() => {
// //         "status": status,
// //         "message": message,
// //         "data": List<dynamic>.from(data.map((x) => x.toJson())),
// //     };
// // }

// // class DepartementsData {
// //     String subId;
// //     String subName;

// //     DepartementsData({
// //         required this.subId,
// //         required this.subName,
// //     });

// //     factory DepartementsData.fromJson(Map<String, dynamic> json) => DepartementsData(
// //         subId: json["Sub_ID"],
// //         subName: json["SubName"],
// //     );

// //     Map<String, dynamic> toJson() => {
// //         "Sub_ID": subId,
// //         "SubName": subName,
// //     };
// // }
