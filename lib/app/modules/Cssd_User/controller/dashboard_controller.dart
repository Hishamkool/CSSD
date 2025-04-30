import 'dart:developer';
import 'package:cssd/app/api/dio_interceptors/dio_interceptor.dart';
import 'package:cssd/app/modules/Cssd_User/model/dashboard_models/get_cssd_list_model.dart';
import 'package:cssd/util/app_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DashboardController extends ChangeNotifier {
  //admin previlege - checks if user has both privilege for cssd login and department login

  // dashboard tabbar selection
  int _selectedTabbarIndex = 0;
  int get selectedTabbarIndex => _selectedTabbarIndex;
  // dashboard tabbar update
  void updateSelectedIndex(int index) {
    _selectedTabbarIndex = index;
    notifyListeners();
    if (kDebugMode) {
      log("Selected tab bar index : $_selectedTabbarIndex ");
    }
  }

  //update bottom nav bar index
  int _selectedIndexBotomNav = 0;
  int get selectedIndexBotomNav => _selectedIndexBotomNav;

  void updateBottomNav(int index) {
    _selectedIndexBotomNav = index;
    notifyListeners();
    if (kDebugMode) {
      log("Selected bottom navigation bar index : $_selectedIndexBotomNav");
    }
  }

  // functions to get all received sterilization requests --Todays Sterilization requests
  final List<GetCssdListData> _requestList = [];
  List<GetCssdListData> get requestList => _requestList;

  final List<HighMedLowReqModel> _highPriorityRequestList = [];
  List<HighMedLowReqModel> get highPriorityRequestList =>
      _highPriorityRequestList;

  final List<HighMedLowReqModel> _mediumPriorityRequestList = [];
  List<HighMedLowReqModel> get mediumPriorityRequestList =>
      _mediumPriorityRequestList;

  final List<HighMedLowReqModel> _lowPriorityRequestList = [];
  List<HighMedLowReqModel> get lowPriorityRequestList =>
      _lowPriorityRequestList;

  bool _isLoadingRequestsApi = false;

  bool get isLoadingRequestsApi => _isLoadingRequestsApi;

  // for loading indication
  void setReqLoading(bool value) {
    _isLoadingRequestsApi = value;
    notifyListeners();
  }

  Future<void> getCssdRequestList() async {
    setReqLoading(true);
    clearRequestList();

    try {
      final client = await DioUtilAuthorized.createApiClient();
      final response = await client.getCSSDList();
      if (response.status == 200) {
        _requestList.add(response.data);
        _highPriorityRequestList.addAll(response.data.high);
        _mediumPriorityRequestList.addAll(response.data.medium);
        _lowPriorityRequestList.addAll(response.data.low);
      } else {
        showPackageToast(
            backgroundColor: Colors.red,
            text: "api response error : ${response.status}");
      }
    } catch (e) {
      log("excetion while getting request list : $e");
    }
    setReqLoading(false);
    notifyListeners();
  }

  // to clear all the requested items list in the dashboard before fetching new data --Todays Sterilization requests
  void clearRequestList() {
    _requestList.clear();
    _highPriorityRequestList.clear();
    _mediumPriorityRequestList.clear();
    _lowPriorityRequestList.clear();
  }

  
}
