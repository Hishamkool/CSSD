import 'dart:developer';

import 'package:cssd/app/api/dio_interceptors/dio_interceptor.dart';
import 'package:cssd/app/modules/Cssd_User/model/sterilization_models/get_accepted_items_list_model.dart';
import 'package:cssd/app/modules/Cssd_User/model/sterilization_models/get_machine_name_model.dart';
import 'package:cssd/app/modules/Cssd_User/model/sterilization_models/get_process_name_model.dart';
import 'package:cssd/util/app_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SterilizationProvider extends ChangeNotifier {
  TextEditingController quantityController = TextEditingController();
  TextEditingController batchNumberController = TextEditingController();
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
        showPackageToast(
              backgroundColor: Colors.red,
            text: "Error fetching machine names ${response.status}");
      }
    } catch (e) {
      log("exception while getting machine name $e");
      if (kDebugMode) {
        showPackageToast(
              backgroundColor: Colors.red, text: "exception while getting machine name $e");
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
        showPackageToast(
              backgroundColor: Colors.red,
            text: "error fetching process names, status: ${response.status}");
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        log("exception while fetching process names $e");
      }
    }
    notifyListeners();
    return [];
  }

  // function to fetch items for sterilization
  final List<GetAcceptedItemListData> _acceptedItemsList = [];
  List<GetAcceptedItemListData> get acceptedItemsList => _acceptedItemsList;
  Future<List<GetAcceptedItemListData>> getItemsForSterilization(
      String itemname) async {
    _acceptedItemsList.clear();
    //itemname = search queery
    final client = await DioUtilAuthorized.createApiClient();
    try {
      final response = await client.getAcceptedItemList(itemname);
      if (response.status == 200) {
        _acceptedItemsList.addAll(response.data);
        return _acceptedItemsList;
      }
    } catch (e) {
      if (kDebugMode) {
        log("exception occured while fetching items $e");
      }
      return [];
    }
    notifyListeners();
    return [];
  }

  // to know the currently select items data -- eg for quantity validation , selection from items dropdwon
  GetAcceptedItemListData? _selectedAcceptedItemModel;
  GetAcceptedItemListData? get selectedAcceptedItemModel =>
      _selectedAcceptedItemModel;
  // update the selected items model
  set setSelectedAcceptedItemsModel(GetAcceptedItemListData? itemModel) {
    _selectedAcceptedItemModel = itemModel;
    notifyListeners();
  }

  // adding items list before sterilization
  final List<GetAcceptedItemListData> _addedAcceptedItemsList = [];
  List<GetAcceptedItemListData> get addedAcceptedItemsList =>
      _addedAcceptedItemsList;
  void addAcceptedItemsToList(GetAcceptedItemListData itemModel) {
    _addedAcceptedItemsList.add(GetAcceptedItemListData(
        productId: itemModel.productId,
        sid: itemModel.sid,
        productName: itemModel.productName,
        qty: itemModel.qty));
    showPackageToast(
      text: "Successfully added",
      backgroundColor: Colors.green,
    );
    notifyListeners();
  }

  // function to delete or remove items from the list of added accepted items
  void deleteAddedAccepedItemsList(int index) {
    _addedAcceptedItemsList.removeAt(index);
    showPackageToast(text: "Deleted", backgroundColor: Colors.red);
    notifyListeners();
  }
}
