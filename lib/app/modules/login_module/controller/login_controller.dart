import 'dart:developer';
import 'package:cssd/app/modules/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/login_module/model/login_model.dart';
import 'package:cssd/app/modules/login_module/model/pre_login_authentication_model.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/local_storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginController extends ChangeNotifier {
  LoginController() {
    loginPhoneNumberController.addListener(() {
      if (loginPhoneNumberController.text.length != 10) {
        loginHospitalNameController.clear();
        preLoginResponse.clear();
        // updateSelectedHospital("");
        notifyListeners();
      }
      if (loginPhoneNumberController.text.isEmpty) {
        //not necessary - if conditions
        preLoginResponse.clear();
        _isAdmin = false;
      }
    });
  }

  //text controllers
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController loginPhoneNumberController = TextEditingController();
  TextEditingController loginHospitalNameController =
      TextEditingController(); //stores the hospital name , stores entered id only if admin phone number

  //focus node
  final FocusNode focusNodePhone = FocusNode();
  final FocusNode focusNodeHospitalName = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  // show or hide password
  @override
  void dispose() {
    log("login dispose invoked");
    loginPasswordController.dispose();
    loginPhoneNumberController.dispose();
    loginHospitalNameController.dispose();
    focusNodePhone.dispose();
    focusNodeHospitalName.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  bool _obscureText = true;
  bool get obscureText => _obscureText;

  String? _selectedHospitalDropdown;
  String? get selectedHospitalDropdown => _selectedHospitalDropdown;
  bool? _isLoading;
  bool? get isLoading => _isLoading;
  bool _isAdmin = false;
  bool get isAdmin => _isAdmin;
  bool? _preLoginResponseDataReceived;
  bool? get preLoginResponseDataReceived => _preLoginResponseDataReceived;

  void updateSelectedHospital(String? newvalue) {
    //dropdown selected hospital ID
    _selectedHospitalDropdown = newvalue;
    notifyListeners();
  }

  void toggleObscureText(bool value) {
    //visibility of password field
    _obscureText = value;
    notifyListeners();
  }

  //function to call for receiving hospitals lists
  List<Data> preLoginResponse = [];
  Future<void> submitPhoneForHospitalIds(
      String phoneNumber, BuildContext context) async {
    try {
      _isLoading = true;
      _preLoginResponseDataReceived = false;

      notifyListeners();
      final client = await AppUtil.createApiClient();
      PreLoginAuthenticationModel response =
          await client.submitPhoneForHospitalIds(phoneNumber);
      if (response.status == 200) {
        _preLoginResponseDataReceived = true;

        if (response.message == "Please give HID") {
          _isAdmin = true;
          notifyListeners();
        } else {
          preLoginResponse.clear();
          updateSelectedHospital(
              null); // to remove the current selected value form the dropwdown when a new phone number is passed
          preLoginResponse.addAll(response.data ?? []);
        }
      } else if (response.status == 300) {
        _preLoginResponseDataReceived = false;
        _isAdmin = false;
        notifyListeners();
        log("Status 300 : ${response.message}");
      } else if (response.status == 404) {
        //invalid user
        _preLoginResponseDataReceived = false;
        _isAdmin = false;
        notifyListeners();
        log("Status 300 : ${response.message}");
        showPackageToast(backgroundColor: Colors.red, text: "${response.message}");
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isAdmin = false;

      _preLoginResponseDataReceived = false;

      log("exception : $e");
    }
  }

  final List<String> _privileges = [];

  List<String> get privileges => _privileges;
  // function to login
  Future<bool> login(BuildContext context) async {
    // returns true when both privileges are present
    await LocalStorageManager.setBool(StorageKeys.privilegeFlagCssdAndDept,
        false); //initially set it to false
    Map<String, dynamic> body = {
      "PhoneNumber": loginPhoneNumberController.text,
      "Password": loginPasswordController.text,
      "Hospitals": _selectedHospitalDropdown ??
          loginHospitalNameController
              .text //when selecting dropdown its _selected hospital has value otherwise its the entered value in the hospital id text field
    };

    try {
      final client = await AppUtil.createApiClient();
      LoginModel response = await client.login(body);
      if (response.status == 200) {
        //when status is 200 save the user name and their previleges and redirect them to their required screen by checking the previleges
        LocalStorageManager.setString(StorageKeys.loginToken, response.token!);
        LocalStorageManager.setString(
            StorageKeys.loggedinUser, response.username!);
        _privileges.clear();

        _privileges.addAll(response.getPrivileges());
        LocalStorageManager.setStringList(
            StorageKeys.loggedinUserPrivilegesList, _privileges);
        log("privileges list is : ${_privileges.toString()}");
        if (_privileges.isEmpty) {
          /* 
          Privileges
          312 - cssd
          315 - cssd add stock
          316 - send to cssd
          317 - cssd admin
          318 - dept cssd report 
          */
          showPackageToast(
              backgroundColor: Colors.red, text: "You dont have Privilege");
          return false;
        } else if (_privileges.contains("312") && _privileges.contains("316")) {
          await LocalStorageManager.setBool(
              StorageKeys.privilegeFlagCssdAndDept, true);
          /* insted of navigating show bottom sheet by returning true */

          return true;
        } else if (_privileges.contains("312")) {
          await LocalStorageManager.setBool(
              StorageKeys.privilegeFlagCssdAndDept, false);
          Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.bottomNavBarDashboardCssdUser,
              (Route<dynamic> route) => false);
          return false;
        } else if (_privileges.contains("316")) {
          await LocalStorageManager.setBool(
              StorageKeys.privilegeFlagCssdAndDept, false);
          Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.dashboardViewCssdCussDeptUser,
              (Route<dynamic> route) => false);
          return false;
        }
        log("prefs - login token : ${LocalStorageManager.getString(StorageKeys.loginToken)}");
      } else if (response.status == 300) {
        // check password
        log(response.message.toString());
        showPackageToast(
            backgroundColor: Colors.red,
            text: "Check credentials , ${response.message}");
        return false;
      } else if (response.status == 500) {
        log(response.message.toString());
        showPackageToast(
          text: "Network Error , ${response.message}",
          backgroundColor: Colors.red,
        );
        return false;
      } else if (response.status == 404) {
        // invalid user
        log(response.message.toString());
        showPackageToast(
          text: "User Not Found ,${response.message}",
          backgroundColor: Colors.red,
        );
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
    return false;
  }

  Future<void> logoutFunction(BuildContext context) async {
    log("before clearing storage values are :");
    LocalStorageManager.printAllValues();
    await LocalStorageManager.remove(StorageKeys.selectedDepartmentCounter);
    await LocalStorageManager.clear();
    log("Clearing all values in local storage manager");
    // clears all values inside the local storage manager
    LocalStorageManager.printAllValues();
    context
        .read<DashboardControllerCssdCussDeptUser>()
        .clearAllData(); // clearing all data in dashboard -- add other lists to clear inside the funcion

    loginPasswordController.clear();
    loginPhoneNumberController.clear();
    loginHospitalNameController.clear();
  }
}
