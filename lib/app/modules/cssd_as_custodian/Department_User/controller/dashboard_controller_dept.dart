import 'dart:developer';

import 'package:cssd/app/api/dio_interceptors/dio_interceptor.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/dahboard_models/get_request_details_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/dahboard_models/pie_dept_stock_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/sterilization_models/department_list_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/sterilization_models/items_list_model.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/local_storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardControllerCssdCussDeptUser extends ChangeNotifier {
  late String? selectedDepartment;
  DashboardControllerCssdCussDeptUser() {
    selectedDepartment = LocalStorageManager.getString(StorageKeys.selectedDepartmentCounter);
  }

  final TextEditingController searchController = TextEditingController();

  
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // String _selectedDepartment =
  //     LocalStorageManager.getString(StorageKeys.selectedDepartmentCounter) ??
  //         "";
  // String get getSelectedDepartment => _selectedDepartment;
  // set selectedDepartment(String? value) {
  //   if (value != null) {
  //     _selectedDepartment = value;
  //     log("selected department is : $getSelectedDepartment");
  //     notifyListeners();
  //   }
  // }

//department dropdown fetch
  List<GetDepartmentListModelData> _departmentDropdownItems = [];
  List<GetDepartmentListModelData> get departmentDropdownItems =>
      _departmentDropdownItems;

  Future<List<GetDepartmentListModelData>> departmentDropdownFunction() async {
    _departmentDropdownItems.clear();
    final client = await DioUtilAuthorized.createApiClient();
    try {
      _isLoading = true;
      notifyListeners();
      final resposne = await client.getDepartementListData();
      if (resposne.status == 200) {
        _departmentDropdownItems = resposne.data ?? [];
        _isLoading = false;
        notifyListeners();
        return _departmentDropdownItems;
      } else {
        _isLoading = false;
        log("status code !200  :  ${resposne.message}");
        return [];
      }
    } catch (e) {
      log("exception : $e");
      return [];
    }
  }

  // adding pie chart data to list of map
  final List<Map<String, dynamic>> _pieChartData = [];
  List<Map<String, dynamic>> get pieChartData => _pieChartData;
  void addToList(String label, int data) {
    // add request count or other data to
    _pieChartData.add({label: data});
    log("pie chart data list : $_pieChartData");
  }

  // fetching data for pie chart
  late int _requestCount;
  late String _requestString;
  late int _pendingCount;
  late String _pendingString;
  bool hasValidData =
      false; // if  request count = 0 & pending count is 0 4 the dept , set false to false to show lottie

  Future<void> getPieChartData(String selectedDepartment) async {
    _pieChartData.clear();
    final client = await DioUtilAuthorized.createApiClient();
    try {
      final requestCountResponse =
          await client.getRequestedCount(selectedDepartment);
      final pendingRequestCountResponse =
          await client.getPendingRequestCount(selectedDepartment);
      if (requestCountResponse.status == 200 &&
          pendingRequestCountResponse.status == 200) {
        _requestCount = requestCountResponse.data;
        _requestString = requestCountResponse.message;
        log("Piechart request data is label: $_requestString, value: $_requestCount");
        addToList(_requestString, _requestCount);
        _pendingCount = pendingRequestCountResponse.data;
        _pendingString = pendingRequestCountResponse.message;
        log("Piechart pending data is label: $_pendingString, value: $_pendingCount");
        addToList(_pendingString, _pendingCount);
        if (_requestCount == 0 && _pendingCount == 0) {
          hasValidData = false;
        } else {
          hasValidData = true;
        }
      }
      notifyListeners();
    } catch (e) {
      log("Error fetching pie chart data: $e");
    }
  }

  // to fetch the details of the requests in pie chart on tap
  List<RequestDetailsData> _requestDetailsList = [];
  List<RequestDetailsData> get requestDetailsList => _requestDetailsList;
  Future<void> fetchRequestDetails(String selectedDepartment) async {
    requestDetailsList.clear();
    final client = await DioUtilAuthorized.createApiClient();
    try {
      final response = await client.getRequestDetails(selectedDepartment);
      if (response.status == 200) {
        _requestDetailsList = response.data;
      }
      notifyListeners();
    } catch (e) {
      log("Exception caught : $e");
    }
  }

  //fetch pending request details
  Future<void> fetchPendingRequestDetails() async {
    requestDetailsList.clear();
    final client = await DioUtilAuthorized.createApiClient();
    try {
      if (selectedDepartment == null) {
        showSnackBarNoContext(isError: true, msg: "Select Department ");
      }else{
      final response =
          await client.getPendingRequestdetails(selectedDepartment!);
      if (response.status == 200) {
        _requestDetailsList = response.data;
      }
      notifyListeners();

      }
    } catch (e) {
      log("Exception caught : $e");
      showSnackBarNoContext(
          isError: true, msg: "Caught Exception pending request");
    }
  }

  //fetching department stock details and adding search functionality by using filtered list
  List<DepartmentStockData> _deptStockList = [];
  List<DepartmentStockData> get deptStockList => _deptStockList;
  List<DepartmentStockData> _filteredDeptStockList = [];
  List<DepartmentStockData> get filteredDeptStockList => _filteredDeptStockList;

  Future<List<DepartmentStockData>> fetchDepartmentwiseStockDetails(String selectedDepartment) async {
    final client = await DioUtilAuthorized.createApiClient();
    try {
      final deptStockResponse =
          await client.getDepartmentwiseStockDetails(selectedDepartment);

      if (deptStockResponse.status == 200) {
        _deptStockList = deptStockResponse.data;
        _filteredDeptStockList = List.from(_deptStockList);

        notifyListeners();
        return _deptStockList;
      }
      return [];
    } catch (e) {
      log("Error fetching department stock data: $e");
      return [];
    }
  }

  //filtered list for search
  Future<List<DepartmentStockData>> filterFutureList(String? query, String selectedDepartment) async {
    if (query == null || query.isEmpty) {
      await fetchDepartmentwiseStockDetails(selectedDepartment);
      _filteredDeptStockList = List.from(deptStockList);
    } else {
      _filteredDeptStockList = deptStockList
          .where((item) =>
              item.productName.toLowerCase().contains(query.toLowerCase()))
          .toList();

      log(_filteredDeptStockList.length.toString());
    }
    notifyListeners();
    return _filteredDeptStockList;
  }

  /* Common apis for department user */
}
