import 'package:flutter/material.dart';

class StockControllerDepartment extends ChangeNotifier {

  StockControllerDepartment() {
    // listeners for checking if value changed 
    sterilizedQuantityCntrl.addListener(_onValueChanged);
    unsterilizedQuantityCntrl.addListener(_onValueChanged);
  }

  // to update the text field when ever the value changes 
  void _onValueChanged() {
    notifyListeners();
  }

  final TextEditingController sterilizedQuantityCntrl = TextEditingController();
  final TextEditingController unsterilizedQuantityCntrl =
      TextEditingController();
  final TextEditingController itemsSearchController = TextEditingController();

   


  @override
  void dispose() {
    sterilizedQuantityCntrl.dispose();
    unsterilizedQuantityCntrl.dispose();
    itemsSearchController.dispose();
    super.dispose();
  }
}
