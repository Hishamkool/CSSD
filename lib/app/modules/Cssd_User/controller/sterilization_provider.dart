import 'dart:developer';

import 'package:cssd/app/api/dio_interceptors/dio_interceptor.dart';
import 'package:cssd/app/modules/Cssd_User/model/sterilization_models/get_machine_name_model.dart';
import 'package:cssd/app/modules/Cssd_User/model/sterilization_models/get_process_name_model.dart';
import 'package:cssd/util/app_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SterilizationProvider extends ChangeNotifier {
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController processNameController = TextEditingController();


  String? selectedMachine;
  bool _expansionTileExpanded = true;

  bool get expansionTileExpanded => _expansionTileExpanded;

  void updateExpansionTileStatus(bool value) {
    _expansionTileExpanded = value;
    notifyListeners();
  }

  void updateSelectedMachine(String? newMachine) {
    selectedMachine = newMachine;
    notifyListeners();
  }

  // function to get machine names
  final List<GetMachineNameData> _machinesList = [];
  List<GetMachineNameData> get getmachinesList => _machinesList;

  Future<void> getMachineNames() async {
    _machinesList.clear();
    final client = await DioUtilAuthorized.createApiClient();
    try {
      final response = await client.getMachineName();
      if (response.status == 200) {
        _machinesList.addAll(response.data);
      } else {
        showSnackBarNoContext(
            isError: true,
            msg: "Error fetching machine names ${response.status}");
      }
    } catch (e) {
      log("exception while getting machine name $e");
      if (kDebugMode) {
        showSnackBarNoContext(
            isError: true, msg: "exception while getting machine name $e");
      }
    }
    notifyListeners();
  }

  // to fetch the sterilization process names from the database
  Future<List<GetProcessNameData>> getProcessName(String processQuerry) async {
    final client = await DioUtilAuthorized.createApiClient();
    final response = await client.getProcessName(processQuerry);
    try {
      if (response.status == 200) {
        return response.data;
      } else {
        showSnackBarNoContext(
            isError: true,
            msg: "error fetching process names, status: ${response.status}");
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        log("exception while fetching process names $e");
      }
    }
    notifyListeners();
    return [];
  }
}
