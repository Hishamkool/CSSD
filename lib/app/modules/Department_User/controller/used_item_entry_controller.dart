import 'dart:convert';
import 'dart:developer';

import 'package:cssd/app/api/dio_interceptors/dio_interceptor.dart';
import 'package:cssd/app/modules/Department_User/model/used_item_model/departmentwise_used_item_model.dart';
import 'package:cssd/app/modules/Department_User/model/used_item_model/get_package_details_model.dart';
import 'package:cssd/app/modules/Department_User/model/used_item_model/items_list_model.dart';
import 'package:cssd/app/modules/Department_User/model/used_item_model/post_used_items_body_model.dart';
import 'package:cssd/app/modules/Department_User/model/used_item_model/used_items_model.dart';
import 'package:cssd/util/app_util.dart';
import 'package:flutter/material.dart';

class UsedItemEntryController extends ChangeNotifier {
  TextEditingController quantityController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool validateQuantity() {
    return formKey.currentState!.validate();
  }

  GetItemNameModelData? _selectedItemModel;
  GetItemNameModelData? get getSelectedItemModel => _selectedItemModel;
  set setSelectedItemModel(GetItemNameModelData? value) {
    _selectedItemModel = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //fetch items list for selected department
  final List<GetItemNameModelData> _itemsList = [];
  List<GetItemNameModelData> get getItemsList => _itemsList;
  List<String> _itemsNames =
      []; //un used for now , to list just item names without other details
  List<String> get itemsNames => _itemsNames;
  // final String selectedDepartment = LocalStorageManager.getString(StorageKeys.selectedDepartmentCounter) ;
  Future<void> fetchItems(
      {required String itemname, required String department}) async {
    _itemsList.clear();
    final client = await DioUtilAuthorized.createApiClient();
    try {
      _isLoading = true;
      notifyListeners();
      final response = await client.getItemName(department, itemname);
      _itemsList.addAll(response.data ?? []);
      _itemsNames = _itemsList.map((item) => item.productName ?? '').toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      log("exception : $e");
    }
  }

  //fetch if there is enough quantity of items left for user item entry
  bool _isQtyValid = false;
  bool get getIsQtyValid => _isQtyValid;
  set isQtyValid(bool value) {
    _isQtyValid = value;
    notifyListeners();
  }

  Future<bool> qtyValidation({
    required int qty,
    required int productid,
    required String location,
    required bool isPckg, //send isPckg as String
  }) async {
    final client = await DioUtilAuthorized.createApiClient();
    try {
      final response = await client.getQtyValidation(
          qty, productid, location, "$isPckg"); //general response
      if (response.status == 200) {
        //quantity valid
        showPackageToast(backgroundColor: Colors.green, text: response.message);
        _isQtyValid = true;
        return true;
      } else if (response.status == 206) {
        showPackageToast(
            backgroundColor: Colors.red,
            text: "Check if all values are passed");
        log("Quantity validation error-206, passed values can be null , passed values are $isPckg,$location,$productid,$qty");
        return false;
      } else if (response.status == 300) {
        //quantity greater than current stock
        showPackageToast(backgroundColor: Colors.red, text: response.message);
        return false;
      } else {
        log("some error occured status code : ${response.status} message: ${response.message}");
        return false;
      }
    } catch (e) {
      log("Exception at quality validation $e");
      return false;
    }
  }

  //adding single items to the used items table before sending
  final List<UsedItemsListModelData> _usedItemsTableBeforeSubmitList = [];
  List<UsedItemsListModelData> get getUsedItemsTableBeforeSubmitList =>
      _usedItemsTableBeforeSubmitList;

  //For clearing the table
  void clearusedItemsTableBeforeSubmitList() {
    _usedItemsTableBeforeSubmitList.clear();
    _listMapAddedItem.clear();
    notifyListeners();
  }

  //for used items entry format
  final List<Uentry> _listMapAddedItem = [];

  List<UsedItemsListModelData> addToUsedItemsTableBeforeSubmit({
    required int productId,
    required String productName,
    required String location,
    required int uQty,
    required BuildContext context,
  }) {
    final existingItemIndex = _usedItemsTableBeforeSubmitList
        .indexWhere((item) => item.productId == productId);
    if (existingItemIndex == -1) {
      // item does not exist when index returns -1
      _usedItemsTableBeforeSubmitList.add(UsedItemsListModelData(
          productId: productId,
          productName: productName,
          location: location,
          uQty: uQty));

      _listMapAddedItem.add(
          Uentry(location: location, productId: productId, quantity: uQty));
      log("added list $_listMapAddedItem");
    } else if (existingItemIndex != -1) {
      //when item already exists in the list
      final quantity = _usedItemsTableBeforeSubmitList[existingItemIndex].uQty;
      final bool sameQnty =
          int.parse(quantityController.text) == quantity ? true : false;
      // dialog to update the quantity if needed
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Item Already Exists"),
            content: sameQnty
                ? const Text("Item already exist with same quantity")
                : Text(
                    "Item already exists with quantity: $quantity.\nDo you want to update the quantity to ${quantityController.text}?"),
            actions: <Widget>[
              TextButton(
                child:
                    sameQnty ? /*  */ const Text("cancel") : const Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: sameQnty
                    ? const Text("ok")
                    : /* need to update */ const Text("Yes"),
                onPressed: () {
                  _usedItemsTableBeforeSubmitList[existingItemIndex].uQty =
                      uQty;
                  if (!sameQnty) {
                    showPackageToast(
                        backgroundColor: Colors.green,
                        text: "Item quantity updated!");
                  }

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    notifyListeners();
    return _usedItemsTableBeforeSubmitList;
  }

  // adding package items to used items list / table
  final List<UsedItemsListModelData> _selectedItemsFromPackage = [];
  List<UsedItemsListModelData> get slectedItemsFormPackage =>
      _selectedItemsFromPackage;

  void addPackageItemsToUSedItemsTable(
      {required String department, required BuildContext context}) {
    log("added list $_listMapAddedItem");

    // adding each item to the list of items for used items table and then addign it to itemsMap list to send later on
    for (var index = 0; index < packageItemsList.length; index++) {
      final item = packageItemsList[index];
      // checking if item already exist
      final existingItemIndex = _usedItemsTableBeforeSubmitList
          .indexWhere((item) => item.productId == item.productId);

      if (existingItemIndex == -1) {
        // item does not exist when index returns -1
        // ading items to table
        _usedItemsTableBeforeSubmitList.add(UsedItemsListModelData(
            productId: item.id,
            productName: item.productName,
            location: department,
            uQty: item.pckQty));
        // adding items to a list in a format for used items entry
        _listMapAddedItem.add(Uentry(
            location: department, productId: item.id, quantity: item.pckQty));
      } else if (existingItemIndex != -1) {
        // item already exist
        showPackageToast(
            backgroundColor: Colors.red,
            text: "This item already exists item: ${item.productName} ");
      }
    }
    notifyListeners();
  }

  // for used item ENTRY
  Future<bool> submitUsedItemsEntries() async {
    final client = await DioUtilAuthorized.createApiClient();
    try {
      log("list of map data for user items entry :  ${jsonEncode(_listMapAddedItem)}");
      log("post used items , body : ${PostUsedItemsEntryModel(uentry: _listMapAddedItem)}");
      log("post used items , body : $jsonDecode($_listMapAddedItem)");
      final response = await client.postUsedItemsEntry(
          PostUsedItemsEntryModel(uentry: _listMapAddedItem)); 
      if (response.status == 200) {
        if (_listMapAddedItem.isEmpty) {
          showPackageToast(text: "No items in list");
          return false;
        } else {
          showPackageToast(
              backgroundColor: Colors.green, text: response.message);
        }
        return true;
      } else {
        showPackageToast(backgroundColor: Colors.red, text: response.message);
        return false;
      }
    } catch (e) {
      log("Exception caught while posting used items $e");
      showPackageToast(backgroundColor: Colors.red, text: "$e");
      return false;
    }
  }

  // api to fetch already saved used items and list them for a paricular department - Used items SHOW
  final List<DepartmentwiseUsedItemListData> _departmentWiseUsedItemsList = [];
  List<DepartmentwiseUsedItemListData> get getDepartmentWiseUsedItemsList =>
      _departmentWiseUsedItemsList;

  Future<void> fetchDepartmentWiseUsedItems(String location) async {
    _departmentWiseUsedItemsList.clear();
    final client = await DioUtilAuthorized.createApiClient();
    try {
      final response = await client.departmentwiseUsedItemList(location);
      if (response.status == 200) {
        _departmentWiseUsedItemsList.addAll(response.data);
      }
    } catch (e) {
      log("exception while fetchind department wise useditems list $e");
      showPackageToast(text: "$e", backgroundColor: Colors.red);
    }
    notifyListeners();
  }

  //to fetch items within a package to add to list
  bool _isLoadingPackageItems = false;
  bool get islodingPackageItems => _isLoadingPackageItems;
  final List<GetPackagedetailsData> _packageItemsList = [];
  List<GetPackagedetailsData> get packageItemsList => _packageItemsList;

  Future<void> fetchItemsWithPackage(
      {required String department, required int pckid}) async {
    _packageItemsList.clear();
    _isLoadingPackageItems = true;
    notifyListeners();
    final client = await DioUtilAuthorized.createApiClient();
    try {
      final response = await client.getPackagedetails(department, pckid);
      if (response.status == 200) {
        _packageItemsList.addAll(response.data);
      }
    } catch (e) {
      log("exception at fetching items within a package $e");
    } finally {
      _isLoadingPackageItems = false;
      notifyListeners();
    }
  }
}
