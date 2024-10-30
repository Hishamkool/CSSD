import 'package:cssd/Widgets/custom_dialog.dart';
import 'package:cssd/app/modules/login_module/model/pre_login_authentication_model.dart';
import 'package:cssd/util/app_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  LoginController() {
    loginPhoneNumberController.addListener(() {
      if (loginPhoneNumberController.text.length != 10) {
        loginHospitalNameController.clear();
      }
      notifyListeners();
    });
  }
  // show or hide password
  bool _obscureText = false;
  bool get obscureText => _obscureText;
  bool? _isLoading;
  bool? get isLoading => _isLoading;
  bool? _preLoginResponseDataReceived;
  bool? get preLoginResponseDataReceived => _preLoginResponseDataReceived;
  bool _isHospitalTextfieldenabled = false;
  bool? get isHospitalTextfieldenabled => _isHospitalTextfieldenabled;

  void toggleHospitalTextFieldStatus(bool value) {
    //to make the textfield readonly
    _isHospitalTextfieldenabled = value;
    notifyListeners();
  }

  void toggleObscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  //text controllers
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController loginPhoneNumberController = TextEditingController();
  TextEditingController loginHospitalNameController = TextEditingController();

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
        print("prelogin success 200");
        preLoginResponse.clear();
        preLoginResponse.addAll(response.data ?? []);
        if (preLoginResponse.isNotEmpty) {
          // should enable and disable the hospital text field
          // when phone entered && data is not empty read only and ontap
          // when phone entered && data is empty enable text field
          // when phone not entered  disable text field

          customDialog(
              dialogContext: context,
              dialogShowDefaultActions: false,
              dialogTitle: const Text("Select Hospital"),
              dialogContent: SizedBox(
                width: 200,
                height: 250,
                child: ListView.builder(
                  itemCount: preLoginResponse.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        onTap: () {
                          loginHospitalNameController.text =
                              preLoginResponse[index].hospitalName!;
                          Navigator.pop(context);
                        },
                        title: Text(preLoginResponse[index].hospitalName ??
                            " hospital name fetch error"));
                  },
                ),
              ));
        }
      } else if (response.status == 300) {
        _preLoginResponseDataReceived = false;

        print("Status 300 : ${response.message}");
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _preLoginResponseDataReceived = false;

      print(e);
    }
  }
}
