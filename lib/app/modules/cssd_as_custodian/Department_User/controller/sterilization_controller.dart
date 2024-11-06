import 'dart:convert';
import 'dart:developer';

import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/depart_dropdown_jsonserializable.dart';
import 'package:cssd/util/app_util.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';

class SterilizationControllerCssdCussDeptUser extends ChangeNotifier {
  SterilizationControllerCssdCussDeptUser() {
    deparmentList();
  }

  List<Datum> departments = [];
  List<DropdownMenuEntry<dynamic>> departmentDropDownEntries = [];
  Future<void> deparmentList() async {
    final client = await AppUtil.createAdminTokenApiClient();
    HttpResponse<DepartmentListModel> response =
        await client.getDepartementList();

    if (response.response.statusCode == 200) {
      if (response.response.data != null) {
        departments = response.response.data;
        log("API response data: ${response.response.data}");

        printList(departments);
        departmentDropDownEntries = departments.map((e) {
          return DropdownMenuEntry<dynamic>(
            value: e.subId,
            label: e.subName!,
          );
        }).toList();
        printList("department dropdown list $departmentDropDownEntries");
      } else {
        departments = [];
        log("Department list received is empty");
      }
    } else {
      log("response other than 200");
    }

    notifyListeners();
  }

  void callDepartmentList() {
    //if you need to refresh department list
    deparmentList();
    notifyListeners();
  }

  void printList(var list) {
    log("List is : $list");
  }

  // List<DropdownMenuEntry<dynamic>> departmentDropDownEntries = [];
  // List<DepartementsData> deparmentsDataList = [];
  // void getDepartmentsDropdown () async{
  //   final client = await AppUtil.createAdminTokenApiClient();
  //   String result = await client.getDepartementList();
  //   Map<String, dynamic> fullDataList = jsonDecode(result);
  //   Map<String, dynamic> departmentList  = {
  //     "data" : fullDataList
  //   };
  //   DepartmentListModel departmentListModel =  DepartmentListModel.fromJson(departmentList);

  //   deparmentsDataList.clear();
  //   if (((departmentListModel.data) ?? []).isNotEmpty) {
  //     deparmentsDataList.addAll(departmentListModel.data);
  //      departmentDropDownEntries = deparmentsDataList.map((e) {
  //           return DropdownMenuEntry<dynamic>(
  //             value: e.subId,
  //             label: e.subName,
  //           );
  //         }).toList();
  //   }
  // notifyListeners();
  // }
}
