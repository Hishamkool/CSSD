import 'dart:developer';

import 'package:cssd/app/api/dio_interceptors/dio_interceptor.dart';
import 'package:cssd/app/modules/Cssd_User/model/request_models/accept_request_model.dart';
import 'package:cssd/app/modules/Cssd_User/model/dashboard_models/get_cssd_det_model.dart';
import 'package:cssd/util/app_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RequestControler extends ChangeNotifier {
  late final List<DropdownMenuEntry<String>> _dropdownMenuEntries;
  RequestControler() {
    //init state

    //initially _filtered users will be whole list  of users
    _filteredRequestedUsers = _sampleRequestedUsers;
    _dropdownMenuEntries = _sampleDepartmentName
        .map((department) =>
            DropdownMenuEntry(value: department, label: department))
        .toList();
  }

  final ScrollController scrollController = ScrollController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController departmentTextController =
      TextEditingController();
  final TextEditingController requestedUserTextController =
      TextEditingController();

  //list of search filtered users
  List<String> _filteredRequestedUsers = [];
  String? _selectedUser;
  bool _showDropDown = false;
  final bool _isChecked = false;
  bool get isChecked => _isChecked;

  //original list of users
  final List<String> _sampleRequestedUsers = [
    "Muhammed Hisham",
    "Vishnu P.S",
    "John Smith",
    "Emily Johnson",
    "Michael Brown",
    "Jessica Williams",
    "David Jones",
    "Sarah Davis",
    "James Miller",
    "Ashley Wilson",
    "Robert Moore",
    "Sophia Taylor",
  ];

  final List<String> _sampleDepartmentName = [
    "Cardiology",
    "Neurology",
    "Pediatrics",
    "	Obstetrics and Gynecology",
    "Oncology",
    "Orthopedics",
    "Radiology",
    "Pathology",
    "General Surgery"
        "Urology",
    "Dermatology",
    "Gastroenterology",
    "Nephrology",
    "Pulmonology",
    "Psychiatry",
  ];

  //Getters
  List<String> get filteredRequestedUsers => _filteredRequestedUsers;
  List<String> get allRequestedUsers => _sampleRequestedUsers;
  List<DropdownMenuEntry<String>> get dropdownMenuEntries =>
      _dropdownMenuEntries;
  String? get selectedUser => _selectedUser;
  bool get showDropDown => _showDropDown;

  //function to update the filterlist
  void filterUsers(String searchQuery) {
    if (searchQuery.isEmpty) {
      _filteredRequestedUsers = _sampleRequestedUsers;
    } else {
      _filteredRequestedUsers = _sampleRequestedUsers
          .where(
              (user) => user.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  //funtion to update the selected user
  void updateSelectedUser(String? user) {
    _selectedUser = user;
    notifyListeners();
  }

  //function to update the show dropdown bool
  void updateShowDropdown(bool value) {
    _showDropDown = value;
    notifyListeners();
  }

  // function to get details of the request list -- request details page    
  final List<GetCssdDetData> _requestDetailsDataList = [];
  List<GetCssdDetData> get requestDetailsDataList => _requestDetailsDataList;
  Future<void> getCssdRequestListDetails(int requestID) async {
    _requestDetailsDataList.clear();
    final client = await DioUtilAuthorized.createApiClient();
    try {
      final response = await client.getCssdDet(requestID);
      _requestDetailsDataList.clear();
      if (response.status == 200) {
        _requestDetailsDataList.addAll(response.data);
      } else {
        showPackageToast(  backgroundColor: Colors.red, text: "something went wrong");
        if (kDebugMode) {
          log("response error ${response.status} , message : ${response.message}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        log("exception while fetching request details $e");
      }
    }
    notifyListeners();
  }

  

  // function to accept the current request
  final List<AcceptRequestData> _acceptedRequest = [];
  List<AcceptRequestData> get acceptedRequest => _acceptedRequest;
  Future<bool> acceptCurrentRequest(int requestID) async {
    final client = await DioUtilAuthorized.createApiClient();
    try {
      final response = await client.acceptRequest(requestID);
      if (response.status == 200) {
        _acceptedRequest.add(response.data);
        showPackageToast(  backgroundColor: Colors.green, text: "Successfully accepted");
        return true;
        // succesfully accepted
      } else {
        showPackageToast(
              backgroundColor: Colors.red,
            text: "Some error occured, status:${response.status}");
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        log("exception occured while accepting the current request $e");
        showPackageToast(  backgroundColor: Colors.red, text: "$e");
      }
      return false;
    }
  }
}
